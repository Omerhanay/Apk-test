import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/security/app_lock.dart';
import 'package:life_os/core/security/authenticator.dart';
import 'package:life_os/features/today/today_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

void main() {
  testWidgets('first run shows the welcome, then the app after unlocking', (tester) async {
    final h = TestHarness(prefs: const {});
    await tester.pumpWidget(await h.build());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to LIFE OS'), findsOneWidget);
    expect(find.byType(TodayScreen), findsNothing);

    await tester.tap(find.text('Set up app lock'));
    await tester.pumpAndSettle();

    expect(find.byType(TodayScreen), findsOneWidget);
    expect((await SharedPreferences.getInstance()).getBool('onboarded_v1'), isTrue);
    final actions = (await h.db.select(h.db.auditLogs).get()).map((a) => a.action);
    expect(actions, containsAll(['app_unlocked', 'permissions_seeded']));
    expect(await h.db.select(h.db.permissions).get(), isNotEmpty);
    await h.dispose(tester);
  });

  testWidgets('personal screens are not built while locked', (tester) async {
    final h = TestHarness(authOutcome: AuthOutcome.cancelled);
    await tester.pumpWidget(await h.build());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();

    expect(find.text('LIFE OS is locked'), findsOneWidget);
    expect(find.byType(TodayScreen), findsNothing);
    expect(find.byType(NavigationBar), findsNothing);
    await h.dispose(tester);
  });

  testWidgets('explains how to proceed when the phone has no screen lock', (tester) async {
    final h = TestHarness(authOutcome: AuthOutcome.noCredential);
    await tester.pumpWidget(await h.build());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Set a screen lock'), findsOneWidget);
    expect(find.byType(TodayScreen), findsNothing);
    await h.dispose(tester);
  });

  testWidgets('relocks after the grace period in the background', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    expect(find.byType(TodayScreen), findsOneWidget);

    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    h.now = h.now.add(AppLockController.gracePeriod);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpAndSettle();

    expect(find.text('LIFE OS is locked'), findsOneWidget);
    expect(find.byType(TodayScreen), findsNothing);
    await h.dispose(tester);
  });
}
