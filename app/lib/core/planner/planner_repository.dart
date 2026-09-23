import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/database.dart';
import '../text/search_fold.dart';
import '../time/recurrence.dart';
import 'notification_scheduler.dart';

class TaskDraft {
  const TaskDraft({
    required this.title,
    this.notes,
    this.due,
    this.allDay = false,
    this.priority = Priority.normal,
    this.recurrence,
    this.remind = true,
    this.source = Source.userStated,
    this.sourceRef,
  });

  final String title;
  final String? notes;
  final DateTime? due;
  final bool allDay;
  final Priority priority;
  final Recurrence? recurrence;

  /// Schedule a reminder at the due time (09:00 for all-day tasks).
  final bool remind;
  final Source source;
  final String? sourceRef;
}

class EventDraft {
  const EventDraft({
    required this.title,
    required this.startsAt,
    this.endsAt,
    this.location,
    this.remindBefore,
    this.source = Source.userStated,
    this.sourceRef,
  });

  final String title;
  final DateTime startsAt;
  final DateTime? endsAt;
  final String? location;

  /// Reminder offset before the start; null for no reminder.
  final Duration? remindBefore;
  final Source source;
  final String? sourceRef;
}

/// Open tasks split the way the Tasks tab and Today screen show them.
class TaskBuckets {
  const TaskBuckets({required this.overdue, required this.today, required this.upcoming, required this.someday});
  final List<Task> overdue;
  final List<Task> today;
  final List<Task> upcoming;
  final List<Task> someday;
}

/// A task is overdue once its due time has passed; an all-day task only once
/// its day has ended.
TaskBuckets bucketTasks(Iterable<Task> open, DateTime now) {
  final startOfToday = DateTime(now.year, now.month, now.day);
  final startOfTomorrow = DateTime(now.year, now.month, now.day + 1);
  final overdue = <Task>[], today = <Task>[], upcoming = <Task>[], someday = <Task>[];
  for (final t in open) {
    final due = t.dueAt;
    if (due == null) {
      someday.add(t);
    } else if (t.allDay ? due.isBefore(startOfToday) : due.isBefore(now)) {
      overdue.add(t);
    } else if (due.isBefore(startOfTomorrow)) {
      today.add(t);
    } else {
      upcoming.add(t);
    }
  }
  int byDue(Task a, Task b) => a.dueAt!.compareTo(b.dueAt!);
  overdue.sort(byDue);
  today.sort(byDue);
  upcoming.sort(byDue);
  someday.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return TaskBuckets(overdue: overdue, today: today, upcoming: upcoming, someday: someday);
}

/// Tasks, events and their reminders. Every write is local-first and audited
/// by id; notifications are (re)scheduled alongside the rows they belong to.
class PlannerRepository {
  PlannerRepository(this._db, this._notifications, {DateTime Function()? clock, String Function()? newId})
      : _now = clock ?? DateTime.now,
        _newId = newId ?? const Uuid().v7;

  final LifeDatabase _db;
  final NotificationScheduler _notifications;
  final DateTime Function() _now;
  final String Function() _newId;

  static const allDayReminderHour = 9;

  // ----- Tasks -----------------------------------------------------------

  Stream<List<Task>> watchOpenTasks() =>
      (_db.select(_db.tasks)..where((t) => t.deletedAt.isNull() & t.status.equalsValue(TaskStatus.open))).watch();

  Future<List<Task>> openTasks() =>
      (_db.select(_db.tasks)..where((t) => t.deletedAt.isNull() & t.status.equalsValue(TaskStatus.open))).get();

  Future<Task?> task(String id) => (_db.select(_db.tasks)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<String> createTask(TaskDraft d, {String actor = 'user'}) {
    return _db.transaction(() async {
      final now = _now();
      final id = _newId();
      await _db.into(_db.tasks).insert(TasksCompanion.insert(
            id: id,
            source: d.source,
            sourceRef: Value(d.sourceRef),
            createdAt: now,
            updatedAt: now,
            title: d.title.trim(),
            notes: Value(d.notes),
            priority: Value(d.priority),
            dueAt: Value(d.due),
            allDay: Value(d.allDay),
            recurrenceRule: Value(d.recurrence?.toRule()),
          ));
      if (d.remind && d.due != null) await _remindAt(d.title, _taskReminderTime(d.due!, d.allDay), id);
      await _audit(actor, 'task_created', 'task', id);
      return id;
    });
  }

  /// Marks a task done. A repeating task gets its next occurrence, carrying
  /// over whether it had a reminder; returns that occurrence's id.
  Future<String?> completeTask(String id, {String actor = 'user'}) {
    return _db.transaction(() async {
      final t = await task(id);
      if (t == null || t.status != TaskStatus.open) return null;
      final now = _now();
      final hadReminder = (await _remindersFor(id)).isNotEmpty;
      await (_db.update(_db.tasks)..where((r) => r.id.equals(id))).write(TasksCompanion(
        status: const Value(TaskStatus.done),
        completedAt: Value(now),
        updatedAt: Value(now),
      ));
      await _cancelRemindersFor(id);
      await _audit(actor, 'task_completed', 'task', id);

      final rule = Recurrence.parse(t.recurrenceRule);
      if (rule == null || t.dueAt == null) return null;
      // Skip occurrences that are already in the past (e.g. completed late).
      final startOfToday = DateTime(now.year, now.month, now.day);
      bool past(DateTime d) => t.allDay ? d.isBefore(startOfToday) : !d.isAfter(now);
      var nextDue = rule.next(t.dueAt!);
      while (past(nextDue)) {
        nextDue = rule.next(nextDue);
      }
      return createTask(
        TaskDraft(
          title: t.title,
          notes: t.notes,
          due: nextDue,
          allDay: t.allDay,
          priority: t.priority,
          recurrence: rule,
          remind: hadReminder,
          source: t.source,
          sourceRef: t.id,
        ),
        actor: actor,
      );
    });
  }

  Future<void> reopenTask(String id) => _db.transaction(() async {
        await (_db.update(_db.tasks)..where((r) => r.id.equals(id))).write(TasksCompanion(
          status: const Value(TaskStatus.open),
          completedAt: const Value(null),
          updatedAt: Value(_now()),
        ));
        await _audit('user', 'task_reopened', 'task', id);
      });

  Future<void> updateTask(String id, TaskDraft d) => _db.transaction(() async {
        await (_db.update(_db.tasks)..where((r) => r.id.equals(id))).write(TasksCompanion(
          title: Value(d.title.trim()),
          notes: Value(d.notes),
          dueAt: Value(d.due),
          allDay: Value(d.allDay),
          priority: Value(d.priority),
          recurrenceRule: Value(d.recurrence?.toRule()),
          updatedAt: Value(_now()),
        ));
        await _cancelRemindersFor(id);
        if (d.remind && d.due != null) await _remindAt(d.title, _taskReminderTime(d.due!, d.allDay), id);
        await _audit('user', 'task_edited', 'task', id);
      });

  Future<void> deleteTask(String id) => _db.transaction(() async {
        await _cancelRemindersFor(id);
        await (_db.delete(_db.reminders)..where((r) => r.targetId.equals(id))).go();
        await (_db.delete(_db.tasks)..where((r) => r.id.equals(id))).go();
        await _audit('user', 'task_deleted', 'task', id);
      });

  Future<List<Task>> searchTasks({String? query, String status = 'open', DateTime? dueAfter, DateTime? dueBefore}) async {
    final rows = await (_db.select(_db.tasks)
          ..where((t) => t.deletedAt.isNull())
          ..where((t) => switch (status) {
                'open' => t.status.equalsValue(TaskStatus.open),
                'done' => t.status.equalsValue(TaskStatus.done),
                _ => const Constant(true),
              })
          ..where((t) => dueAfter == null ? const Constant(true) : t.dueAt.isBiggerOrEqualValue(dueAfter))
          ..where((t) => dueBefore == null ? const Constant(true) : t.dueAt.isSmallerOrEqualValue(dueBefore))
          ..orderBy([(t) => OrderingTerm.asc(t.dueAt)]))
        .get();
    final terms = searchTerms(query ?? '');
    if (terms.isEmpty) return rows;
    return rows.where((t) => terms.every(foldForSearch('${t.title} ${t.notes ?? ''}').contains)).toList();
  }

  DateTime _taskReminderTime(DateTime due, bool allDay) =>
      allDay ? DateTime(due.year, due.month, due.day, allDayReminderHour) : due;

  // ----- Events ----------------------------------------------------------

  Stream<List<Event>> watchEventsBetween(DateTime from, DateTime to) => (_db.select(_db.events)
        ..where((e) => e.deletedAt.isNull() & e.startsAt.isBiggerOrEqualValue(from) & e.startsAt.isSmallerThanValue(to))
        ..orderBy([(e) => OrderingTerm.asc(e.startsAt)]))
      .watch();

  Future<List<Event>> searchEvents({String? query, required DateTime start, required DateTime end}) async {
    final rows = await (_db.select(_db.events)
          ..where((e) => e.deletedAt.isNull() & e.startsAt.isBiggerOrEqualValue(start) & e.startsAt.isSmallerOrEqualValue(end))
          ..orderBy([(e) => OrderingTerm.asc(e.startsAt)]))
        .get();
    final terms = searchTerms(query ?? '');
    if (terms.isEmpty) return rows;
    return rows.where((e) => terms.every(foldForSearch('${e.title} ${e.location ?? ''}').contains)).toList();
  }

  Future<String> createEvent(EventDraft d, {String actor = 'user'}) {
    if (d.endsAt != null && d.endsAt!.isBefore(d.startsAt)) {
      throw ArgumentError('An event cannot end before it starts');
    }
    return _db.transaction(() async {
      final now = _now();
      final id = _newId();
      await _db.into(_db.events).insert(EventsCompanion.insert(
            id: id,
            source: d.source,
            sourceRef: Value(d.sourceRef),
            createdAt: now,
            updatedAt: now,
            title: d.title.trim(),
            startsAt: d.startsAt,
            endsAt: Value(d.endsAt),
            location: Value(d.location),
          ));
      if (d.remindBefore != null) await _remindAt(d.title, d.startsAt.subtract(d.remindBefore!), id);
      await _audit(actor, 'event_created', 'event', id);
      return id;
    });
  }

  Future<void> deleteEvent(String id) => _db.transaction(() async {
        await _cancelRemindersFor(id);
        await (_db.delete(_db.reminders)..where((r) => r.targetId.equals(id))).go();
        await (_db.delete(_db.events)..where((r) => r.id.equals(id))).go();
        await _audit('user', 'event_deleted', 'event', id);
      });

  // ----- Reminders -------------------------------------------------------

  /// A standalone reminder, optionally linked to any other record.
  Future<String> createReminder({required String title, required DateTime fireAt, String? targetId, String actor = 'user'}) =>
      _db.transaction(() async {
        final id = await _remindAt(title, fireAt, targetId);
        await _audit(actor, 'reminder_created', 'reminder', id);
        return id;
      });

  Future<List<Reminder>> _remindersFor(String targetId) => (_db.select(_db.reminders)
        ..where((r) => r.targetId.equals(targetId) & r.status.equals('scheduled')))
      .get();

  Future<String> _remindAt(String title, DateTime fireAt, String? targetId) async {
    final now = _now();
    final id = _newId();
    await _db.into(_db.reminders).insert(RemindersCompanion.insert(
          id: id,
          source: Source.system,
          createdAt: now,
          updatedAt: now,
          title: title.trim(),
          fireAt: fireAt,
          targetId: Value(targetId),
        ));
    // A reminder in the past is kept for the record but never fires.
    if (fireAt.isAfter(now)) {
      await _notifications.schedule(ScheduledNotification(key: id, title: title.trim(), at: fireAt));
    }
    return id;
  }

  Future<void> _cancelRemindersFor(String targetId) async {
    for (final r in await _remindersFor(targetId)) {
      await _notifications.cancel(r.id);
      await (_db.update(_db.reminders)..where((x) => x.id.equals(r.id)))
          .write(RemindersCompanion(status: const Value('dismissed'), updatedAt: Value(_now())));
    }
  }

  /// Re-registers every future reminder with the OS, e.g. after a restore.
  Future<int> rescheduleAll() async {
    final now = _now();
    final pending = await (_db.select(_db.reminders)
          ..where((r) => r.status.equals('scheduled') & r.fireAt.isBiggerThanValue(now) & r.deletedAt.isNull()))
        .get();
    for (final r in pending) {
      await _notifications.schedule(ScheduledNotification(key: r.id, title: r.title, at: r.fireAt));
    }
    return pending.length;
  }

  Future<void> _audit(String actor, String action, String type, String id) =>
      _db.audit(actor: actor, action: action, outcome: 'ok', targetType: type, targetId: id, at: _now());
}
