import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/planner/notification_scheduler.dart';
import 'package:life_os/core/planner/planner_repository.dart';
import 'package:life_os/core/planner/planner_tools.dart';
import 'package:life_os/core/time/recurrence.dart';

class FakeNotifications implements NotificationScheduler {
  final scheduled = <String, ScheduledNotification>{};
  bool permissionGranted = true;

  @override
  Future<void> schedule(ScheduledNotification n) async => scheduled[n.key] = n;
  @override
  Future<void> cancel(String key) async => scheduled.remove(key);
  @override
  Future<bool> requestPermission() async => permissionGranted;
}

void main() {
  late LifeDatabase db;
  late FakeNotifications notifications;
  late PlannerRepository repo;
  late DateTime now;
  var n = 0;

  setUp(() {
    db = LifeDatabase(NativeDatabase.memory());
    notifications = FakeNotifications();
    now = DateTime(2026, 9, 23, 10); // Wednesday
    repo = PlannerRepository(db, notifications, clock: () => now, newId: () => 'id${++n}');
  });
  tearDown(() => db.close());

  Future<List<Task>> open() => repo.openTasks();

  test('a timed task gets a reminder at its due time', () async {
    final id = await repo.createTask(TaskDraft(title: 'Call insurance', due: DateTime(2026, 9, 24, 9)));
    final reminder = await (db.select(db.reminders)).getSingle();
    expect(reminder.targetId, id);
    expect(notifications.scheduled[reminder.id]!.at, DateTime(2026, 9, 24, 9));
  });

  test('an all-day task is reminded at 09:00 that day', () async {
    await repo.createTask(TaskDraft(title: 'Dentist', due: DateTime(2026, 10, 22), allDay: true));
    expect(notifications.scheduled.values.single.at, DateTime(2026, 10, 22, 9));
  });

  test('no reminder is scheduled for the past or when turned off', () async {
    await repo.createTask(TaskDraft(title: 'Old', due: DateTime(2026, 9, 1, 9)));
    await repo.createTask(TaskDraft(title: 'Quiet', due: DateTime(2026, 9, 30, 9), remind: false));
    expect(notifications.scheduled, isEmpty);
  });

  test('completing cancels the reminder', () async {
    final id = await repo.createTask(TaskDraft(title: 'Call', due: DateTime(2026, 9, 24, 9)));
    expect(await repo.completeTask(id), isNull);
    expect(notifications.scheduled, isEmpty);
    expect(await open(), isEmpty);
    expect(await repo.completeTask(id), isNull, reason: 'completing twice is a no-op');
  });

  test('completing a repeating task creates the next occurrence with a reminder', () async {
    final id = await repo.createTask(TaskDraft(
      title: 'Gym',
      due: DateTime(2026, 9, 28, 7),
      recurrence: const Recurrence(Frequency.weekly),
    ));
    final nextId = await repo.completeTask(id);
    final next = (await repo.task(nextId!))!;
    expect(next.dueAt, DateTime(2026, 10, 5, 7));
    expect(next.recurrenceRule, 'FREQ=WEEKLY');
    expect(next.sourceRef, id, reason: 'linked to the occurrence it follows');
    expect(notifications.scheduled.values.single.at, DateTime(2026, 10, 5, 7));
  });

  test('a repeating task completed late skips missed occurrences', () async {
    final id = await repo.createTask(TaskDraft(
      title: 'Vitamins',
      due: DateTime(2026, 9, 20, 8),
      recurrence: const Recurrence(Frequency.daily),
    ));
    final next = (await repo.task((await repo.completeTask(id))!))!;
    expect(next.dueAt, DateTime(2026, 9, 24, 8), reason: 'today 08:00 has passed at 10:00');
  });

  test('editing reschedules the reminder; deleting removes it', () async {
    final id = await repo.createTask(TaskDraft(title: 'Call', due: DateTime(2026, 9, 24, 9)));
    await repo.updateTask(id, TaskDraft(title: 'Call', due: DateTime(2026, 9, 25, 14)));
    expect(notifications.scheduled.values.single.at, DateTime(2026, 9, 25, 14));
    await repo.deleteTask(id);
    expect(notifications.scheduled, isEmpty);
    expect(await db.select(db.reminders).get(), isEmpty);
    expect((await db.select(db.auditLogs).get()).map((a) => a.action), contains('task_deleted'));
  });

  test('buckets: overdue, today, upcoming, someday', () async {
    await repo.createTask(TaskDraft(title: 'late', due: DateTime(2026, 9, 23, 9)));
    await repo.createTask(TaskDraft(title: 'all-day today', due: DateTime(2026, 9, 23), allDay: true));
    await repo.createTask(TaskDraft(title: 'later today', due: DateTime(2026, 9, 23, 18)));
    await repo.createTask(TaskDraft(title: 'yesterday', due: DateTime(2026, 9, 22), allDay: true));
    await repo.createTask(TaskDraft(title: 'next week', due: DateTime(2026, 9, 30, 9)));
    await repo.createTask(const TaskDraft(title: 'someday'));

    final b = bucketTasks(await open(), now);
    expect(b.overdue.map((t) => t.title), ['yesterday', 'late']);
    expect(b.today.map((t) => t.title), ['all-day today', 'later today'],
        reason: 'an all-day task is not overdue until its day ends');
    expect(b.upcoming.map((t) => t.title), ['next week']);
    expect(b.someday.map((t) => t.title), ['someday']);
  });

  test('events: reminder before start, and no end before start', () async {
    await repo.createEvent(EventDraft(
      title: 'Project meeting',
      startsAt: DateTime(2026, 9, 24, 9),
      remindBefore: const Duration(minutes: 15),
    ));
    expect(notifications.scheduled.values.single.at, DateTime(2026, 9, 24, 8, 45));
    expect(
      () => repo.createEvent(EventDraft(title: 'x', startsAt: DateTime(2026, 9, 24, 9), endsAt: DateTime(2026, 9, 24, 8))),
      throwsArgumentError,
    );
  });

  test('rescheduleAll re-registers only future reminders', () async {
    await repo.createTask(TaskDraft(title: 'a', due: DateTime(2026, 9, 24, 9)));
    await repo.createTask(TaskDraft(title: 'b', due: DateTime(2026, 9, 1, 9)));
    notifications.scheduled.clear();
    expect(await repo.rescheduleAll(), 1);
    expect(notifications.scheduled.values.single.title, 'a');
  });

  group('planner tools', () {
    late PlannerTools tools;
    setUp(() => tools = PlannerTools(repo));

    test('search_tasks filters by date and text, Turkish-aware', () async {
      await repo.createTask(TaskDraft(title: 'Kasko POLİÇESİ yenile', due: DateTime(2026, 10, 1, 9)));
      await repo.createTask(TaskDraft(title: 'Buy milk', due: DateTime(2026, 9, 24, 9)));
      final r = jsonDecode(await tools.searchTasks({'query': 'police', 'due_after': '2026-09-30T00:00:00'})) as List;
      expect(r.single['title'], 'Kasko POLİÇESİ yenile');
    });

    test('search_events returns events in range with ids', () async {
      final id = await repo.createEvent(EventDraft(title: 'Dentist', startsAt: DateTime(2026, 9, 24, 15)));
      final r = jsonDecode(await tools.searchEvents({'start': '2026-09-24T00:00:00', 'end': '2026-09-25T00:00:00'})) as List;
      expect(r.single['id'], id);
      expect(jsonDecode(await tools.searchEvents({'start': '2026-09-25T00:00:00', 'end': '2026-09-26T00:00:00'})), isEmpty);
    });

    test('create tools mark what the AI created and report failure honestly', () async {
      final created = jsonDecode(await tools.createTask({'title': 'Prepare report', 'due_at': '2026-09-25T09:00:00'}, runId: 'run7'));
      expect(created['status'], 'created');
      final t = (await repo.task(created['id'] as String))!;
      expect(t.source, Source.aiInferred);
      expect(t.sourceRef, 'run7');

      final bad = jsonDecode(await tools.createEvent(
          {'title': 'x', 'starts_at': '2026-09-25T09:00:00', 'ends_at': '2026-09-25T08:00:00'},
          runId: 'r'));
      expect(bad['status'], 'failed');
    });
  });
}
