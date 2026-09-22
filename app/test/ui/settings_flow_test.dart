import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:life_os/core/ai/relay_client.dart';

import 'test_app.dart';

void main() {
  const goodToken = 'tok_0123456789abcdef0123456789abcdef';

  RelayClient Function(dynamic) relayReturning(int status, [Map<String, Object>? body]) => (creds) => RelayClient(
        creds,
        httpClient: MockClient((req) async => http.Response(
              jsonEncode(body ?? {'status': 'ok', 'provider': 'anthropic', 'prompt_version': 'agent.v2'}),
              status,
            )),
      );

  Future<void> openRelay(WidgetTester tester) async {
    await tester.tap(find.byTooltip('Settings and privacy'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('AI relay'));
    await tester.pumpAndSettle();
  }

  Future<void> submit(WidgetTester tester, String url, String token) async {
    await tester.enterText(find.widgetWithText(TextField, 'Relay address'), url);
    await tester.enterText(find.widgetWithText(TextField, 'Device token'), token);
    await tester.tap(find.text('Test and save'));
    await tester.pumpAndSettle();
  }

  testWidgets('rejects a non-https relay before contacting it', (tester) async {
    var contacted = false;
    final h = TestHarness(relayClient: (c) => RelayClient(c, httpClient: MockClient((_) async {
          contacted = true;
          return http.Response('{}', 200);
        })));
    await h.pumpUnlocked(tester);
    await openRelay(tester);
    await submit(tester, 'http://relay.example', goodToken);

    expect(find.text('The address must start with https://'), findsOneWidget);
    expect(contacted, isFalse);
    expect(h.secrets.values, isNot(contains('relay_token_v1')));
    await h.dispose(tester);
  });

  testWidgets('does not save a token the relay rejects', (tester) async {
    final h = TestHarness(relayClient: relayReturning(401, {'error': 'unauthorized'}));
    await h.pumpUnlocked(tester);
    await openRelay(tester);
    await submit(tester, 'https://relay.example', goodToken);

    expect(find.text('The relay rejected this token.'), findsOneWidget);
    expect(h.secrets.values.keys, isNot(contains('relay_token_v1')));
    await h.dispose(tester);
  });

  testWidgets('saves credentials after a successful test and records it', (tester) async {
    final h = TestHarness(relayClient: relayReturning(200));
    await h.pumpUnlocked(tester);
    await openRelay(tester);
    await submit(tester, 'https://relay.example', goodToken);

    expect(h.secrets.values['relay_token_v1'], goodToken);
    expect(find.text('Connected'), findsOneWidget);
    expect(find.text(goodToken), findsNothing, reason: 'token field is cleared after saving');

    final audit = await h.db.select(h.db.auditLogs).get();
    expect(audit.map((a) => a.action), contains('relay_paired'));
    expect(audit.any((a) => (a.targetId ?? '').contains(goodToken)), isFalse);
    await h.dispose(tester);
  });

  testWidgets('permission toggles persist and appear in the activity log', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await tester.tap(find.byTooltip('Settings and privacy'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Permissions'));
    await tester.pumpAndSettle();

    expect(find.text('Your documents'), findsOneWidget);
    expect(find.text('Ask me first'), findsWidgets);

    await tester.tap(find.widgetWithText(SwitchListTile, 'Your documents'));
    await tester.pumpAndSettle();
    final row = await (h.db.select(h.db.permissions)..where((p) => p.capability.equals('READ_DOCUMENTS'))).getSingle();
    expect(row.granted, isFalse);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Activity'));
    await tester.pumpAndSettle();
    expect(find.text('Permission turned off'), findsOneWidget);
    expect(find.textContaining('Your documents'), findsOneWidget);
    await h.dispose(tester);
  });
}
