import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/features/tasks/quick_add_sheet.dart';
import 'package:life_os/features/tasks/tasks_screen.dart';

import 'test_app.dart';

// Harness clock: Tuesday 22 September 2026, 09:00.

Finder inSheet(Finder f) => find.descendant(of: find.byType(QuickAddSheet), matching: f);
Finder navTab(String label) => find.descendant(of: find.byType(NavigationBar), matching: find.text(label));

Future<void> quickAdd(WidgetTester tester, String text, {String add = 'Add task', String save = 'Add', String? kind}) async {
  await tester.tap(find.byTooltip(add));
  await tester.pumpAndSettle();
  if (kind != null) {
    await tester.tap(inSheet(find.text(kind)));
    await tester.pumpAndSettle();
  }
  await tester.enterText(inSheet(find.byType(TextField)), text);
  await tester.pumpAndSettle();
}

Future<void> tapSave(WidgetTester tester, [String save = 'Add']) async {
  await tester.tap(inSheet(find.widgetWithText(FilledButton, save)));
  await tester.pumpAndSettle();
}

/// The 800×600 test screen is short enough for a snackbar to cover list rows.
Future<void> dismissSnackBar(WidgetTester tester) async {
  tester.state<ScaffoldMessengerState>(find.byType(ScaffoldMessenger)).hideCurrentSnackBar();
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('natural-language quick add previews, saves and schedules a reminder', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'Call insurance tomorrow at 9am');

    expect(inSheet(find.text('Call insurance')), findsOneWidget, reason: 'the parsed title is previewed');
    expect(inSheet(find.text('Tomorrow 09:00')), findsOneWidget);
    await tapSave(tester);

    final task = await h.db.select(h.db.tasks).getSingle();
    expect(task.title, 'Call insurance');
    expect(task.dueAt, DateTime(2026, 9, 23, 9));
    expect(h.notifications.scheduled.values.single.at, DateTime(2026, 9, 23, 9));
    expect(h.notifications.permissionRequests, 1);

    await tester.tap(navTab('Tasks'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Upcoming'));
    await tester.pumpAndSettle();
    expect(find.text('Call insurance'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('Turkish quick add', (tester) async {
    final h = TestHarness(prefs: const {'onboarded_v1': true, 'locale': 'tr'});
    await h.pumpUnlocked(tester);
    await quickAdd(tester, "Yarın 9'da sigortayı ara", add: 'Görev ekle');
    expect(inSheet(find.text('sigortayı ara')), findsOneWidget);
    expect(inSheet(find.text('Yarın 09:00')), findsOneWidget);
    await tapSave(tester, 'Ekle');
    expect((await h.db.select(h.db.tasks).getSingle()).dueAt, DateTime(2026, 9, 23, 9));
    await h.dispose(tester);
  });

  testWidgets('without a date nothing is scheduled and the task lands in Someday', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'Buy milk');
    expect(inSheet(find.text('No date')), findsOneWidget);
    expect(inSheet(find.text('Remind me')), findsNothing);
    await tapSave(tester);
    expect(h.notifications.scheduled, isEmpty);
    expect(h.notifications.permissionRequests, 0, reason: 'no permission prompt without a reminder');
    await h.dispose(tester);
  });

  testWidgets('overdue tasks surface on Today and can be completed with undo', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'Send report 21.09.2026');
    await tapSave(tester);
    await dismissSnackBar(tester);

    expect(find.text('NEEDS ATTENTION'), findsOneWidget);
    expect(find.text('1 overdue task'), findsOneWidget);
    await tester.tap(find.descendant(of: find.widgetWithText(TaskTile, 'Send report'), matching: find.byType(Checkbox)));
    await tester.pumpAndSettle();
    expect(find.text('Done'), findsOneWidget);
    expect(find.text('All clear'), findsOneWidget);

    await tester.tap(find.text('Undo'));
    await tester.pumpAndSettle();
    expect(find.text('1 overdue task'), findsOneWidget);
    expect((await h.db.select(h.db.tasks).getSingle()).status, TaskStatus.open);
    await h.dispose(tester);
  });

  testWidgets('completing a repeating task shows when it comes back', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'every tuesday gym 18:00');
    expect(inSheet(find.text('Every week')), findsOneWidget);
    await tapSave(tester);
    await dismissSnackBar(tester);

    await tester.tap(find.descendant(of: find.widgetWithText(TaskTile, 'gym'), matching: find.byType(Checkbox)));
    await tester.pumpAndSettle();
    expect(find.textContaining('Done. Next:'), findsOneWidget);
    final open = await (h.db.select(h.db.tasks)..where((t) => t.status.equalsValue(TaskStatus.open))).get();
    expect(open.single.dueAt, DateTime(2026, 9, 29, 18));
    await h.dispose(tester);
  });

  testWidgets('an event needs a time; with one it shows under Happening', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'Dentist 25.09.2026', kind: 'Event');
    await tapSave(tester);
    expect(inSheet(find.text('An event needs a start time.')), findsOneWidget);
    expect(await h.db.select(h.db.events).get(), isEmpty);

    await tester.enterText(inSheet(find.byType(TextField)), 'Project meeting today at 18:00');
    await tester.pumpAndSettle();
    await tapSave(tester);

    expect(find.text('HAPPENING'), findsOneWidget);
    expect(find.text('Project meeting'), findsOneWidget);
    expect(find.text('18:00'), findsOneWidget);
    expect(h.notifications.scheduled.values.single.at, DateTime(2026, 9, 22, 17, 45));
    await h.dispose(tester);
  });

  testWidgets('editing a task and deleting it', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    await quickAdd(tester, 'Pay rent tomorrow');
    await tapSave(tester);
    await tester.tap(navTab('Tasks'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Upcoming'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Pay rent'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Task'), 'Pay rent and bills');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Pay rent and bills'), findsOneWidget);

    await tester.tap(find.text('Pay rent and bills'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete task'));
    await tester.pumpAndSettle();
    expect(find.text('Task deleted'), findsOneWidget);
    expect(await h.db.select(h.db.tasks).get(), isEmpty);
    expect(h.notifications.scheduled, isEmpty);
    await h.dispose(tester);
  });
}
