import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'documents_flow_test.dart' show navTab, reveal;
import 'test_app.dart';

// Harness clock: Tuesday 22 September 2026, 09:00.

Future<void> openLife(WidgetTester tester) async {
  await tester.tap(navTab('Life'));
  await tester.pumpAndSettle();
}

Future<void> pickDay(WidgetTester tester, String chip, String day) async {
  await tester.tap(find.text(chip));
  await tester.pumpAndSettle();
  await tester.tap(find.text(day));
  await tester.tap(find.text('OK'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a person is added from the People tab and opens on their page', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await openLife(tester);
    await tester.tap(find.text('People'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'Add person'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Elif');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Elif'), findsOneWidget, reason: 'the person page is open');
    expect(find.text('Nothing mentions Elif yet.'), findsOneWidget);

    await reveal(tester, find.text('Add date'));
    await tester.tap(find.text('Add date'));
    await tester.pumpAndSettle();
    await pickDay(tester, 'Pick a date', '25');
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();

    expect(find.text('Birthday'), findsOneWidget);
    expect(find.text('Next: September 25, 2026 · Every year · Remind me 7 days before'), findsOneWidget);
    expect(h.notifications.scheduled.values.single.at, DateTime(2027, 9, 18, 9),
        reason: 'this year\'s reminder day has passed, so next year\'s is set');
    await h.dispose(tester);
  });

  testWidgets('a thing with an inspection date shows in Things and on the timeline', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await openLife(tester);

    await tester.tap(find.byTooltip('Add to Life'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add thing'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Car');
    await tester.tap(find.text('Add date'));
    await tester.pumpAndSettle();
    await pickDay(tester, 'Pick a date', '30');
    await tester.tap(find.widgetWithText(FilledButton, 'Add'));
    await tester.pumpAndSettle();
    expect(find.text('Inspection'), findsOneWidget, reason: 'listed in the sheet before saving');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(find.text('Car'), findsOneWidget);
    expect(find.text('September 30, 2026 · Remind me 30 days before'), findsOneWidget);
    expect(h.notifications.scheduled, isEmpty, reason: '30 days before is already past');

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Car'), findsOneWidget, reason: 'timeline shows the date');
    await tester.tap(find.text('Things'));
    await tester.pumpAndSettle();
    expect(find.text('Vehicle · Inspection Sep 30'), findsOneWidget);
    await h.dispose(tester);
  });
}
