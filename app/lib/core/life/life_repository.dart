import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/database.dart';
import '../planner/planner_repository.dart';
import '../text/search_fold.dart';

/// Relations a person can have to the user.
const personRelations = ['spouse', 'child', 'parent', 'sibling', 'relative', 'friend', 'colleague', 'other'];

/// Kinds of things the user tracks. Documents create their own entities with
/// document types; these are the ones the user adds by hand.
const thingTypes = ['vehicle', 'home', 'subscription', 'device', 'pet', 'other'];

/// Dates a thing can have.
const thingDateKinds = ['expires', 'renews', 'inspection', 'service', 'payment', 'other'];

/// A date to store on a person or thing. [yearly] dates recur every year.
class DateDraft {
  const DateDraft({required this.kind, required this.date, this.yearly = false, this.remindDaysBefore});
  final String kind;
  final DateTime date;
  final bool yearly;

  /// Null for no reminder.
  final int? remindDaysBefore;
}

/// Someone or something in the user's life, with its dates.
class LifeEntity {
  const LifeEntity(this.entity, this.dates);
  final Entity entity;
  final List<EntityDate> dates;

  Map<String, dynamic> get attributes => jsonDecode(entity.attributes) as Map<String, dynamic>;
  String? get relation => attributes['relation'] as String?;
  String? get notes => attributes['notes'] as String?;
  bool get isPerson => entity.type == 'person';

  /// Birthdays are stored in year 2000 (a leap year, so 29 February fits) when
  /// the year of birth is unknown.
  bool get birthYearKnown => attributes['birth_year_known'] == true;
}

enum TimelineKind { event, taskDue, taskDone, document, memory, date }

/// One line on the timeline. [route] opens the item it came from.
class TimelineItem {
  const TimelineItem({required this.at, required this.kind, required this.title, this.detail, this.route, this.allDay = false});
  final DateTime at;
  final TimelineKind kind;
  final String title;

  /// For [TimelineKind.date]: the date kind (birthday, expires, …).
  final String? detail;
  final String? route;
  final bool allDay;
}

/// Builds the notification title for a date reminder, in the user's language.
typedef ReminderTitle = String Function(String name, String kind, DateTime occurrence);

String _defaultTitle(String name, String kind, DateTime occurrence) => '$name · $kind';

/// People, things and the timeline. Dates can carry reminders; yearly dates
/// (birthdays, anniversaries, yearly renewals) are re-armed on every unlock by
/// [ensureUpcomingReminders], since each reminder fires once.
class LifeRepository {
  LifeRepository(this._db, this._planner, {DateTime Function()? clock, String Function()? newId})
      : _now = clock ?? DateTime.now,
        _newId = newId ?? const Uuid().v7;

  final LifeDatabase _db;
  final PlannerRepository _planner;
  final DateTime Function() _now;
  final String Function() _newId;

  static const reminderHour = 9;
  static const _yearly = 'FREQ=YEARLY';

  // ----- Read ------------------------------------------------------------

  Stream<List<LifeEntity>> watchPeople() => _watch((e) => e.type.equals('person'));

  /// Things the user added by hand; document entities belong to Documents.
  Stream<List<LifeEntity>> watchThings() =>
      _watch((e) => e.type.equals('person').not() & e.source.equalsValue(Source.userStated));

  Stream<List<LifeEntity>> _watch(Expression<bool> Function($EntitiesTable) filter) {
    final query = _db.select(_db.entities)
      ..where((e) => e.deletedAt.isNull() & filter(e))
      ..orderBy([(e) => OrderingTerm.asc(e.displayName)]);
    // Re-read dates whenever entities change; dates change only with their entity here.
    return query.watch().asyncMap((rows) async => [for (final e in rows) LifeEntity(e, await _datesOf(e.id))]);
  }

  Future<LifeEntity?> byId(String id) async {
    final e = await (_db.select(_db.entities)..where((x) => x.id.equals(id))).getSingleOrNull();
    return e == null ? null : LifeEntity(e, await _datesOf(id));
  }

  Stream<LifeEntity?> watchById(String id) => (_db.select(_db.entities)..where((x) => x.id.equals(id)))
      .watchSingleOrNull()
      .asyncMap((e) async => e == null ? null : LifeEntity(e, await _datesOf(id)));

  Future<List<EntityDate>> _datesOf(String entityId) => (_db.select(_db.entityDates)
        ..where((d) => d.entityId.equals(entityId) & d.deletedAt.isNull())
        ..orderBy([(d) => OrderingTerm.asc(d.date)]))
      .get();

  /// The next time [d] happens on or after today (itself if not yearly).
  DateTime nextOccurrence(EntityDate d) {
    if (d.recurrenceRule != _yearly) return d.date;
    final today = _today();
    var candidate = _onYear(d.date, today.year);
    if (candidate.isBefore(today)) candidate = _onYear(d.date, today.year + 1);
    return candidate;
  }

  /// Age this year for a person with a known birth year.
  int? ageOnNextBirthday(LifeEntity person) {
    if (!person.birthYearKnown) return null;
    final birthday = person.dates.where((d) => d.kind == 'birthday').firstOrNull;
    if (birthday == null) return null;
    return nextOccurrence(birthday).year - birthday.date.year;
  }

  // ----- Write -----------------------------------------------------------

  Future<String> addPerson({
    required String name,
    required String relation,
    DateTime? birthday,
    bool birthYearKnown = true,
    int? remindDaysBefore = 7,
    String? notes,
    ReminderTitle titleFor = _defaultTitle,
  }) {
    return _db.transaction(() async {
      final id = await _insertEntity(
        type: 'person',
        name: name,
        sensitivity: Sensitivity.personal,
        attributes: {
          'relation': personRelations.contains(relation) ? relation : 'other',
          'notes': ?_blankToNull(notes),
          if (birthday != null) 'birth_year_known': birthYearKnown,
        },
      );
      if (birthday != null) {
        final stored = birthYearKnown ? birthday : DateTime(2000, birthday.month, birthday.day);
        await _addDate(id, name, DateDraft(kind: 'birthday', date: stored, yearly: true, remindDaysBefore: remindDaysBefore), titleFor);
      }
      await _audit('person_added', id);
      return id;
    });
  }

  Future<String> addThing({
    required String name,
    required String type,
    String? notes,
    List<DateDraft> dates = const [],
    ReminderTitle titleFor = _defaultTitle,
  }) {
    return _db.transaction(() async {
      final id = await _insertEntity(
        type: thingTypes.contains(type) ? type : 'other',
        name: name,
        sensitivity: Sensitivity.normal,
        attributes: {'notes': ?_blankToNull(notes)},
      );
      for (final d in dates) {
        await _addDate(id, name, d, titleFor);
      }
      await _audit('thing_added', id);
      return id;
    });
  }

  Future<void> addDate(String entityId, DateDraft d, {ReminderTitle titleFor = _defaultTitle}) => _db.transaction(() async {
        final e = await byId(entityId);
        if (e == null) throw StateError('Unknown entity');
        await _addDate(entityId, e.entity.displayName, d, titleFor);
        await _touch(entityId);
        await _audit('date_added', entityId);
      });

  Future<void> removeDate(String dateId) => _db.transaction(() async {
        final d = await (_db.select(_db.entityDates)..where((x) => x.id.equals(dateId))).getSingleOrNull();
        await _planner.deleteRemindersFor(dateId);
        await (_db.delete(_db.entityDates)..where((x) => x.id.equals(dateId))).go();
        if (d != null) await _touch(d.entityId);
      });

  /// Entity streams watch the entities table; bump it so date changes show.
  Future<void> _touch(String entityId) =>
      (_db.update(_db.entities)..where((x) => x.id.equals(entityId))).write(EntitiesCompanion(updatedAt: Value(_now())));

  Future<void> update(String id, {required String name, String? relation, String? notes}) => _db.transaction(() async {
        final e = await byId(id);
        if (e == null) throw StateError('Unknown entity');
        final attrs = Map<String, dynamic>.from(e.attributes)..remove('notes');
        if (relation != null) attrs['relation'] = personRelations.contains(relation) ? relation : 'other';
        if (_blankToNull(notes) != null) attrs['notes'] = notes!.trim();
        await (_db.update(_db.entities)..where((x) => x.id.equals(id))).write(EntitiesCompanion(
          displayName: Value(name.trim()),
          attributes: Value(jsonEncode(attrs)),
          updatedAt: Value(_now()),
        ));
        await _audit(e.isPerson ? 'person_edited' : 'thing_edited', id);
      });

  /// Removes the entity, its dates, their reminders and its relationships.
  Future<void> delete(String id) => _db.transaction(() async {
        final e = await byId(id);
        if (e == null) return;
        for (final d in e.dates) {
          await _planner.deleteRemindersFor(d.id);
        }
        await (_db.delete(_db.entityDates)..where((d) => d.entityId.equals(id))).go();
        await (_db.delete(_db.entityRelationships)..where((r) => r.fromEntity.equals(id) | r.toEntity.equals(id))).go();
        await (_db.delete(_db.entities)..where((x) => x.id.equals(id))).go();
        await _audit(e.isPerson ? 'person_deleted' : 'thing_deleted', id);
      });

  /// Makes sure every date with a reminder has one scheduled for its next
  /// occurrence. Safe to call repeatedly; returns how many were created.
  Future<int> ensureUpcomingReminders({ReminderTitle titleFor = _defaultTitle}) async {
    final dates = await (_db.select(_db.entityDates)..where((d) => d.deletedAt.isNull() & d.recurrenceRule.equals(_yearly))).get();
    var created = 0;
    for (final d in dates) {
      final lead = d.remindDaysBefore;
      if (lead == null) continue;
      if (await _hasFutureReminder(d.id)) continue;
      final entity = await byId(d.entityId);
      if (entity == null) continue;
      if (await _scheduleFor(d, entity.entity.displayName, lead, titleFor)) created++;
    }
    return created;
  }

  // ----- Related items -----------------------------------------------------

  /// Memories, open tasks and documents that mention [name], Turkish-aware.
  Future<({List<Memory> memories, List<Task> tasks, List<Document> documents})> related(String name) async {
    final terms = searchTerms(name);
    if (terms.isEmpty) return (memories: <Memory>[], tasks: <Task>[], documents: <Document>[]);
    bool mentions(String text) => terms.every(foldForSearch(text).contains);
    final memories = await (_db.select(_db.memories)
          ..where((m) => m.deletedAt.isNull() & m.supersededBy.isNull() & m.validTo.isNull()))
        .get();
    final tasks = await (_db.select(_db.tasks)..where((t) => t.deletedAt.isNull() & t.status.equalsValue(TaskStatus.open))).get();
    final docs = await (_db.select(_db.documents)..where((d) => d.deletedAt.isNull())).get();
    return (
      memories: memories.where((m) => mentions(m.content)).toList(),
      tasks: tasks.where((t) => mentions('${t.title} ${t.notes ?? ''}')).toList(),
      documents: docs.where((d) => mentions('${d.title ?? ''} ${d.fileName}')).toList(),
    );
  }

  // ----- Timeline --------------------------------------------------------

  /// The timeline, recomputed whenever any table changes.
  Stream<List<TimelineItem>> watchTimeline() async* {
    yield await timeline();
    await for (final _ in _db.tableUpdates()) {
      yield await timeline();
    }
  }

  /// What is coming up ([ahead]) and what happened ([behind]), newest first
  /// within each day. Built from existing records; nothing is stored for it.
  Future<List<TimelineItem>> timeline({Duration ahead = const Duration(days: 60), Duration behind = const Duration(days: 90)}) async {
    final now = _now();
    final from = now.subtract(behind);
    final to = now.add(ahead);
    final items = <TimelineItem>[];

    for (final e in await (_db.select(_db.events)
          ..where((e) => e.deletedAt.isNull() & e.startsAt.isBetweenValues(from, to)))
        .get()) {
      items.add(TimelineItem(at: e.startsAt, kind: TimelineKind.event, title: e.title));
    }
    for (final t in await (_db.select(_db.tasks)..where((t) => t.deletedAt.isNull())).get()) {
      if (t.status == TaskStatus.open && t.dueAt != null && !t.dueAt!.isBefore(from) && !t.dueAt!.isAfter(to)) {
        items.add(TimelineItem(at: t.dueAt!, kind: TimelineKind.taskDue, title: t.title, allDay: t.allDay));
      }
      if (t.status == TaskStatus.done && t.completedAt != null && !t.completedAt!.isBefore(from)) {
        items.add(TimelineItem(at: t.completedAt!, kind: TimelineKind.taskDone, title: t.title));
      }
    }
    for (final d in await (_db.select(_db.documents)
          ..where((d) => d.deletedAt.isNull() & d.createdAt.isBiggerOrEqualValue(from)))
        .get()) {
      items.add(TimelineItem(at: d.createdAt, kind: TimelineKind.document, title: d.title ?? d.fileName, route: '/documents/${d.id}'));
    }
    for (final m in await (_db.select(_db.memories)
          ..where((m) => m.deletedAt.isNull() & m.createdAt.isBiggerOrEqualValue(from)))
        .get()) {
      items.add(TimelineItem(at: m.createdAt, kind: TimelineKind.memory, title: m.content, route: '/memory/${m.id}'));
    }
    final entities = {for (final e in await (_db.select(_db.entities)..where((e) => e.deletedAt.isNull())).get()) e.id: e};
    for (final d in await (_db.select(_db.entityDates)..where((d) => d.deletedAt.isNull())).get()) {
      final e = entities[d.entityId];
      if (e == null) continue;
      final at = nextOccurrence(d);
      if (at.isBefore(_today()) || at.isAfter(to)) continue;
      final route = e.source == Source.document && e.sourceRef != null ? '/documents/${e.sourceRef}' : '/life/${e.id}';
      items.add(TimelineItem(at: at, kind: TimelineKind.date, title: e.displayName, detail: d.kind, route: route, allDay: true));
    }
    items.sort((a, b) => b.at.compareTo(a.at));
    return items;
  }

  // ----- Internals -------------------------------------------------------

  Future<String> _insertEntity({
    required String type,
    required String name,
    required Sensitivity sensitivity,
    required Map<String, Object> attributes,
  }) async {
    if (name.trim().isEmpty) throw ArgumentError('A name is required');
    final id = _newId();
    final now = _now();
    await _db.into(_db.entities).insert(EntitiesCompanion.insert(
          id: id,
          source: Source.userStated,
          createdAt: now,
          updatedAt: now,
          type: type,
          displayName: name.trim(),
          sensitivity: Value(sensitivity),
          attributes: Value(jsonEncode(attributes)),
        ));
    return id;
  }

  Future<void> _addDate(String entityId, String name, DateDraft d, ReminderTitle titleFor) async {
    final id = _newId();
    final now = _now();
    await _db.into(_db.entityDates).insert(EntityDatesCompanion.insert(
          id: id,
          source: Source.userStated,
          createdAt: now,
          updatedAt: now,
          entityId: entityId,
          kind: d.kind,
          date: DateTime(d.date.year, d.date.month, d.date.day),
          recurrenceRule: Value(d.yearly ? _yearly : null),
          remindDaysBefore: Value(d.remindDaysBefore),
        ));
    final row = await (_db.select(_db.entityDates)..where((x) => x.id.equals(id))).getSingle();
    if (d.remindDaysBefore != null) await _scheduleFor(row, name, d.remindDaysBefore!, titleFor);
  }

  Future<bool> _hasFutureReminder(String dateId) async {
    final rows = await (_db.select(_db.reminders)
          ..where((r) => r.targetId.equals(dateId) & r.status.equals('scheduled') & r.fireAt.isBiggerThanValue(_now())))
        .get();
    return rows.isNotEmpty;
  }

  /// Schedules a reminder [lead] days before the next occurrence, unless that
  /// moment has already passed. Returns whether one was created.
  Future<bool> _scheduleFor(EntityDate d, String name, int lead, ReminderTitle titleFor) async {
    var occurrence = nextOccurrence(d);
    var at = DateTime(occurrence.year, occurrence.month, occurrence.day - lead, reminderHour);
    // Yearly and this year's reminder time is already behind us: arm next year's.
    if (!at.isAfter(_now()) && d.recurrenceRule == _yearly) {
      occurrence = _onYear(d.date, occurrence.year + 1);
      at = DateTime(occurrence.year, occurrence.month, occurrence.day - lead, reminderHour);
    }
    if (!at.isAfter(_now())) return false;
    await _planner.createReminder(title: titleFor(name, d.kind, occurrence), fireAt: at, targetId: d.id, actor: 'system');
    return true;
  }

  DateTime _today() {
    final n = _now();
    return DateTime(n.year, n.month, n.day);
  }

  /// [date]'s day and month in [year]; 29 February becomes 28 in common years.
  static DateTime _onYear(DateTime date, int year) {
    final lastDay = DateTime(year, date.month + 1, 0).day;
    return DateTime(year, date.month, date.day > lastDay ? lastDay : date.day);
  }

  static String? _blankToNull(String? s) => s == null || s.trim().isEmpty ? null : s.trim();

  Future<void> _audit(String action, String id) =>
      _db.audit(actor: 'user', action: action, outcome: 'ok', targetType: 'entity', targetId: id, at: _now());
}
