import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:life_os/core/ai/relay_client.dart';
import 'package:life_os/features/documents/document_picker.dart';

import '../documents/document_core_test.dart' show kaskoTr, passportEn;
import 'test_app.dart';

// Harness clock: Tuesday 22 September 2026, 09:00.

Finder navTab(String label) => find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

PickedDocument file(String content, {String name = 'kasko.pdf', String mime = 'application/pdf'}) =>
    PickedDocument(name: name, mimeType: mime, bytes: Uint8List.fromList(content.codeUnits));

Future<void> addDocument(WidgetTester tester, TestHarness h, PickedDocument doc) async {
  h.picker.next = doc;
  await tester.tap(navTab('Documents'));
  await tester.pumpAndSettle();
  await tester.tap(find.byTooltip('Add document'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Choose a file'));
  await tester.pumpAndSettle();
}

/// The 800×600 test screen is shorter than a phone; scroll before tapping.
Future<void> reveal(WidgetTester tester, Finder f) async {
  await tester.scrollUntilVisible(f, 150, scrollable: find.byType(Scrollable).last);
  await tester.ensureVisible(f);
  await tester.pumpAndSettle();
}

Future<void> save(WidgetTester tester) async {
  final button = find.widgetWithText(FilledButton, 'Save');
  await reveal(tester, button);
  await tester.tap(button);
  await tester.pumpAndSettle();
}

TestHarness withRelay(List<Map<String, Object?>> replies, {List<Map<String, dynamic>>? sent}) {
  var i = 0;
  final h = TestHarness(
    relayClient: (c) => RelayClient(c, httpClient: MockClient((req) async {
      sent?.add(jsonDecode(req.body) as Map<String, dynamic>);
      // No charset header on purpose: the client must still read UTF-8.
      return http.Response.bytes(utf8.encode(jsonEncode(replies[i++])), 200);
    })),
  );
  h.secrets.values['relay_url_v1'] = 'https://relay.example';
  h.secrets.values['relay_token_v1'] = 'tok_0123456789abcdef0123456789abcdef';
  return h;
}

void main() {
  testWidgets('a policy is read on the phone, reviewed, and its expiry becomes a reminder', (tester) async {
    final h = TestHarness();
    h.ocr.pagesByContent['kasko-file'] = [kaskoTr];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('kasko-file'));

    expect(find.text('Review'), findsOneWidget);
    expect(find.text('Insurance'), findsOneWidget, reason: 'classified on the device');
    expect(find.text('Expires'), findsOneWidget);
    expect(find.text('May 10, 2027'), findsWidgets);
    expect(find.text('“Bitiş Tarihi: 10.05.2027”'), findsOneWidget, reason: 'shows where the value came from');
    expect(find.text('Read on this phone'), findsWidgets);
    await reveal(tester, find.text('Remind me 30 days before'));
    expect(find.text('Remind me 30 days before'), findsOneWidget);
    expect(h.notifications.scheduled, isEmpty, reason: 'nothing is scheduled before Save');

    await save(tester);
    expect(find.text('Saved. Reminder on Apr 10, 2027.'), findsOneWidget);
    expect(h.notifications.scheduled.values.single.at, DateTime(2027, 4, 10, 9));
    expect(h.notifications.scheduled.values.single.title, contains('May 10, 2027'));
    expect(find.text('Policy number'), findsOneWidget, reason: 'now on the detail screen');

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.textContaining('Expires May 10, 2027'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('unticked items are discarded', (tester) async {
    final h = TestHarness();
    h.ocr.pagesByContent['kasko-file'] = [kaskoTr];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('kasko-file'));
    await tester.tap(find.widgetWithText(CheckboxListTile, 'Expires'));
    await tester.pumpAndSettle();
    expect(find.text('Remind me 30 days before'), findsNothing);
    await save(tester);
    expect(find.text('Saved'), findsOneWidget);
    expect(h.notifications.scheduled, isEmpty);
    expect(await h.db.select(h.db.entityDates).get(), hasLength(2), reason: 'start and issue dates kept, expiry not');
    await h.dispose(tester);
  });

  testWidgets('passports are local-only: no AI button even with a relay', (tester) async {
    final h = withRelay(const []);
    h.ocr.pagesByContent['passport-file'] = [passportEn];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('passport-file', name: 'p.jpg', mime: 'image/jpeg'));

    expect(find.text('Passport'), findsOneWidget);
    expect(find.text('ID and health documents are read on this phone only.'), findsOneWidget);
    expect(find.text('Find more with AI'), findsNothing);
    await reveal(tester, find.text('Remind me 180 days before'));
    expect(find.text('Remind me 180 days before'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('AI suggestions are checked against the text before they appear', (tester) async {
    final sent = <Map<String, dynamic>>[];
    final h = withRelay([
      {
        'doc_type': 'insurance',
        'title': 'Kasko – Anadolu Sigorta',
        'fields': [
          {'key': 'provider', 'value': 'Anadolu Sigorta', 'quote': 'ANADOLU SİGORTA A.Ş.', 'confidence': 0.9},
          {'key': 'amount', 'value': '9.999 TL', 'quote': 'Prim: 9.999 TL', 'confidence': 0.9},
        ],
        'prompt_version': 'document-extract.v1',
      },
    ], sent: sent);
    h.ocr.pagesByContent['kasko-file'] = [kaskoTr];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('kasko-file'));

    await tester.tap(find.text('Find more with AI'));
    await tester.pumpAndSettle();
    expect(find.text('1 more item found'), findsOneWidget, reason: 'the invented premium quote is dropped');
    await reveal(tester, find.text('Anadolu Sigorta'));
    expect(find.text('Anadolu Sigorta'), findsOneWidget);
    expect(find.text('9.999 TL'), findsNothing);
    expect((await h.db.select(h.db.documents).getSingle()).title, 'Kasko – Anadolu Sigorta');

    expect(sent.single['text'], contains('KASKO SİGORTA POLİÇESİ'), reason: 'OCR text is sent');
    expect(sent.single.keys.toSet(), {'text', 'doc_type', 'locale', 'today'}, reason: 'never the file itself');
    await h.dispose(tester);
  });

  testWidgets('adding the same file twice opens the existing one', (tester) async {
    final h = TestHarness();
    h.ocr.pagesByContent['kasko-file'] = [kaskoTr];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('kasko-file'));
    await save(tester);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await addDocument(tester, h, file('kasko-file', name: 'copy.pdf'));
    expect(find.text('This document was already added.'), findsOneWidget);
    expect(await h.db.select(h.db.documents).get(), hasLength(1));
    await h.dispose(tester);
  });

  testWidgets('deleting removes the document and its reminder', (tester) async {
    final h = TestHarness();
    h.ocr.pagesByContent['kasko-file'] = [kaskoTr];
    await h.pumpUnlocked(tester);
    await addDocument(tester, h, file('kasko-file'));
    await save(tester);

    await reveal(tester, find.text('Delete document'));
    await tester.tap(find.text('Delete document'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Document deleted'), findsOneWidget);
    expect(await h.db.select(h.db.documents).get(), isEmpty);
    expect(h.notifications.scheduled, isEmpty);
    expect(h.blobs.files, isEmpty);
    await h.dispose(tester);
  });
}
