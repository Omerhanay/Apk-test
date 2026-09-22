import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/features/today/today_screen.dart';
import 'package:life_os/l10n/app_localizations_en.dart';
import 'package:life_os/l10n/app_localizations_tr.dart';

import 'test_app.dart';

void main() {
  testWidgets('shows five tabs and a persistent ask bar', (tester) async {
    final semantics = tester.ensureSemantics();
    final h = TestHarness();
    await h.pumpUnlocked(tester);

    for (final label in ['Today', 'Tasks', 'Documents', 'Life', 'Memory']) {
      expect(find.descendant(of: find.byType(NavigationBar), matching: find.text(label)), findsOneWidget);
    }
    expect(find.bySemanticsLabel('Ask or search your life'), findsOneWidget);

    await tester.tap(find.text('Memory'));
    await tester.pumpAndSettle();
    expect(find.text('LIFE OS knows nothing yet'), findsOneWidget);
    expect(find.bySemanticsLabel('Ask or search your life'), findsOneWidget);
    semantics.dispose();
    await h.dispose(tester);
  });

  testWidgets('ask sheet is honest that it is not connected', (tester) async {
    final semantics = tester.ensureSemantics();
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await tester.tap(find.bySemanticsLabel('Ask or search your life'));
    await tester.pumpAndSettle();
    expect(find.textContaining('not connected yet'), findsOneWidget);
    semantics.dispose();
    await h.dispose(tester);
  });

  test('greeting follows the time of day', () {
    final en = AppLocalizationsEn();
    expect(TodayScreen.greetingFor(DateTime(2026, 9, 22, 8), en), 'Good morning');
    expect(TodayScreen.greetingFor(DateTime(2026, 9, 22, 14), en), 'Good afternoon');
    expect(TodayScreen.greetingFor(DateTime(2026, 9, 22, 21), en), 'Good evening');
    expect(TodayScreen.greetingFor(DateTime(2026, 9, 22, 8), AppLocalizationsTr()), 'Günaydın');
  });
}
