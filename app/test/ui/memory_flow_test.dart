import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:life_os/core/ai/relay_client.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/features/memory/capture_sheet.dart';

import 'test_app.dart';

Map<String, Object?> parse({
  String op = 'create',
  required String content,
  String category = 'vehicle',
  String? subject = 'user.vehicle',
  String? predicate = 'model',
  String? value,
  String sensitivity = 'normal',
  String? needsClarification,
}) =>
    {
      'op': op,
      'content': content,
      'category': category,
      'kind': 'semantic',
      'subject': subject,
      'predicate': predicate,
      'value': value,
      'valid_until': null,
      'sensitivity': sensitivity,
      'confidence': 0.9,
      'needs_clarification': needsClarification,
      'prompt_version': 'memory-parse.v1',
    };

/// A harness whose relay answers memory-parse requests from [replies], in order.
TestHarness withRelay(List<Object> replies, {List<Map<String, dynamic>>? sent}) {
  var i = 0;
  final h = TestHarness(
    relayClient: (c) => RelayClient(c, httpClient: MockClient((req) async {
      sent?.add(jsonDecode(req.body) as Map<String, dynamic>);
      final reply = replies[i++];
      return reply is int ? http.Response('{"error":"upstream_unavailable","retryable":true}', reply) : http.Response(jsonEncode(reply), 200);
    })),
  );
  h.secrets.values['relay_url_v1'] = 'https://relay.example';
  h.secrets.values['relay_token_v1'] = 'tok_0123456789abcdef0123456789abcdef';
  return h;
}

Future<void> openMemory(WidgetTester tester) async {
  await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Memory')));
  await tester.pumpAndSettle();
}

Finder inSheet(Finder f) => find.descendant(of: find.byType(CaptureSheet), matching: f);

Future<void> say(WidgetTester tester, String text, {String add = 'Add memory', String next = 'Continue'}) async {
  await tester.tap(find.byTooltip(add));
  await tester.pumpAndSettle();
  await tester.enterText(inSheet(find.byType(TextField)).first, text);
  await tester.tap(inSheet(find.text(next)));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('without a relay, a memory is filed by hand and nothing leaves the phone', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    expect(find.text('LIFE OS knows nothing yet'), findsOneWidget);

    await say(tester, 'The garage is closed on Sundays');
    expect(find.text('Organize with AI'), findsNothing, reason: 'no relay configured');

    expect(find.text('LIFE OS will remember'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Remembered'), findsOneWidget);
    expect(find.text('The garage is closed on Sundays'), findsOneWidget);
    expect(find.text('You told LIFE OS'), findsOneWidget);
    final row = await h.db.select(h.db.memories).getSingle();
    expect(row.source, Source.userStated);
    expect(row.category, 'other');
    await h.dispose(tester);
  });

  testWidgets('with a relay, the AI proposes and a correction replaces the old fact', (tester) async {
    final sent = <Map<String, dynamic>>[];
    final h = withRelay([
      parse(content: 'My car is a BYD Seal U.', value: 'BYD Seal U'),
      parse(content: 'My car is a Tesla Model Y.', value: 'Tesla Model Y'),
    ], sent: sent);
    await h.pumpUnlocked(tester);
    await openMemory(tester);

    await say(tester, 'my car is a byd seal u');
    expect(find.text('LIFE OS will remember'), findsOneWidget);
    expect(find.text('My car is a BYD Seal U.'), findsOneWidget);
    expect(find.text('Vehicle'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Remembered'), findsOneWidget);

    await say(tester, 'I sold it, now I drive a Tesla Model Y');
    expect(find.text('Replaces: My car is a BYD Seal U.'), findsOneWidget);
    expect(sent.last['known_subjects'], [
      {'subject': 'user.vehicle', 'predicate': 'model'}
    ], reason: 'keys are sent, contents are not');
    expect(jsonEncode(sent.last), isNot(contains('BYD')));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Updated. The previous version is kept in history.'), findsOneWidget);

    expect(find.text('My car is a BYD Seal U.'), findsNothing);
    await tester.tap(find.text('My car is a Tesla Model Y.'));
    await tester.pumpAndSettle();
    expect(find.text('HISTORY'), findsOneWidget);
    expect(find.text('My car is a BYD Seal U.'), findsOneWidget);
    expect(find.textContaining('Replaced'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('"no longer true" retracts the matching fact after confirmation', (tester) async {
    final h = withRelay([
      parse(content: 'My car is a BYD Seal U.'),
      parse(op: 'retract', content: 'I no longer have that car.'),
    ]);
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'my car is a byd');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    await say(tester, 'I sold my car');
    expect(find.text('Mark as no longer true'), findsOneWidget);
    expect(find.text('My car is a BYD Seal U.'), findsWidgets);
    await tester.tap(find.widgetWithText(FilledButton, 'No longer true'));
    await tester.pumpAndSettle();

    expect(find.text('Marked as no longer true'), findsOneWidget);
    expect(find.text('LIFE OS knows nothing yet'), findsOneWidget);
    expect((await h.db.select(h.db.memories).getSingle()).validTo, isNotNull, reason: 'kept, not deleted');
    await h.dispose(tester);
  });

  testWidgets('a retraction with nothing to match changes nothing', (tester) async {
    final h = withRelay([parse(op: 'retract', content: 'I no longer have a boat.', subject: 'user.boat')]);
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'I sold my boat');
    expect(find.textContaining('No matching memory was found'), findsOneWidget);
    expect(await h.db.select(h.db.memories).get(), isEmpty);
    await h.dispose(tester);
  });

  testWidgets('if the AI is unreachable the user can still save it as written', (tester) async {
    final h = withRelay([502]);
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'I prefer morning flights');
    expect(find.textContaining("Couldn't organize it with AI"), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('I prefer morning flights'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('a clarifying question keeps the user on the input step', (tester) async {
    final h = withRelay([parse(content: '', needsClarification: 'Which car do you mean?')]);
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'it is blue');
    expect(find.text('Which car do you mean?'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(await h.db.select(h.db.memories).get(), isEmpty);
    await h.dispose(tester);
  });

  testWidgets('health details are stored as highly sensitive even if the AI says otherwise', (tester) async {
    final h = withRelay([parse(content: 'I am allergic to penicillin.', category: 'health', subject: null, predicate: null)]);
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'penicillin allergy');
    expect(find.textContaining('highly sensitive'), findsOneWidget);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect((await h.db.select(h.db.memories).getSingle()).sensitivity, Sensitivity.specialCategory);
    await h.dispose(tester);
  });

  testWidgets('edit and delete from the detail screen', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await openMemory(tester);
    await say(tester, 'Garage closed Sunday');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Garage closed Sunday'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    await tester.enterText(find.descendant(of: find.byType(AlertDialog), matching: find.byType(TextField)), 'Garage closed Sunday and Monday');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Garage closed Sunday and Monday'), findsOneWidget);
    expect(find.textContaining('Before editing'), findsOneWidget);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Delete this memory?'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();

    expect(find.text('Deleted'), findsOneWidget);
    expect(find.text('LIFE OS knows nothing yet'), findsOneWidget);
    expect(await h.db.select(h.db.memories).get(), isEmpty);
    expect(await h.db.select(h.db.memoryVersions).get(), isEmpty);
    await h.dispose(tester);
  });

  testWidgets('the memory list search is Turkish-aware', (tester) async {
    final h = TestHarness(prefs: const {'onboarded_v1': true, 'locale': 'tr'});
    await h.pumpUnlocked(tester);
    await tester.tap(find.descendant(of: find.byType(NavigationBar), matching: find.text('Hafıza')));
    await tester.pumpAndSettle();
    for (final text in ['Kasko poliçem Anadolu Sigortada', 'Sabah uçuşlarını tercih ederim']) {
      await say(tester, text, add: 'Bilgi ekle', next: 'Devam');
      await tester.tap(find.text('Kaydet'));
      await tester.pumpAndSettle();
    }
    await tester.enterText(find.widgetWithText(TextField, 'Bilgilerde ara'), 'POLİÇE');
    await tester.pumpAndSettle();
    expect(find.text('Kasko poliçem Anadolu Sigortada'), findsOneWidget);
    expect(find.text('Sabah uçuşlarını tercih ederim'), findsNothing);
    await h.dispose(tester);
  });
}
