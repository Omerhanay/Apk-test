import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/life/life_repository.dart';
import 'package:life_os/core/memory/memory_repository.dart';
import 'package:life_os/core/planner/planner_repository.dart';

import '../planner/planner_repository_test.dart' show FakeNotifications;

void main() {
  late LifeDatabase db;
  late FakeNotifications notifications;
  late PlannerRepository planner;
  late LifeRepository repo;
  late DateTime now;

  LifeRepository make() => LifeRepository(db, planner, clock: () => now);

  setUp(() {
    db = LifeDatabase(NativeDatabase.memory());
    notifications = FakeNotifications();
    now = DateTime(2026, 9, 24, 10);
    planner = PlannerRepository(db, notifications, clock: () => now);
    repo = make();
  });
  tearDown(() => db.close());

  test('a person with a birthday gets a yearly date and a reminder a week before', () async {
    final id = await repo.addPerson(name: 'Elif', relation: 'child', birthday: DateTime(2018, 10, 4));
    final p = (await repo.byId(id))!;
    expect(p.isPerson, isTrue);
    expect(p.relation, 'child');
    final birthday = p.dates.single;
    expect(birthday.recurrenceRule, 'FREQ=YEARLY');
    expect(repo.nextOccurrence(birthday), DateTime(2026, 10, 4));
    expect(repo.ageOnNextBirthday(p), 8);
    expect(notifications.scheduled.values.single.at, DateTime(2026, 9, 27, 9));
  });

  test('a birthday that has passed this year points at next year', () async {
    await repo.addPerson(name: 'Can', relation: 'friend', birthday: DateTime(1990, 3, 1));
    expect(notifications.scheduled.values.single.at, DateTime(2027, 2, 22, 9));
  });

  test('unknown birth year: no age, and 29 February falls on the 28th in common years', () async {
    final id = await repo.addPerson(name: 'Deniz', relation: 'sibling', birthday: DateTime(2000, 2, 29), birthYearKnown: false);
    final p = (await repo.byId(id))!;
    expect(repo.ageOnNextBirthday(p), isNull);
    expect(repo.nextOccurrence(p.dates.single), DateTime(2027, 2, 28));
  });

  test('yearly reminders are re-armed after they fire, and only once', () async {
    await repo.addPerson(name: 'Elif', relation: 'child', birthday: DateTime(2018, 10, 4));
    expect(await repo.ensureUpcomingReminders(), 0, reason: 'already armed');

    // A year later, after this year's reminder has fired.
    now = DateTime(2026, 10, 5, 10);
    final later = make();
    expect(await later.ensureUpcomingReminders(), 1);
    expect(notifications.scheduled.values.map((n) => n.at), contains(DateTime(2027, 9, 27, 9)));
    expect(await later.ensureUpcomingReminders(), 0);
  });

  test('no reminder without a lead time', () async {
    await repo.addPerson(name: 'Ayşe', relation: 'colleague', birthday: DateTime(1985, 12, 1), remindDaysBefore: null);
    expect(notifications.scheduled, isEmpty);
    expect(await repo.ensureUpcomingReminders(), 0);
  });

  test('a thing with a one-off date and a yearly one', () async {
    final id = await repo.addThing(name: 'BYD Seal U', type: 'vehicle', dates: [
      DateDraft(kind: 'inspection', date: DateTime(2027, 5, 10), remindDaysBefore: 30),
      DateDraft(kind: 'service', date: DateTime(2026, 11, 1), yearly: true, remindDaysBefore: 7),
    ]);
    final t = (await repo.byId(id))!;
    expect(t.entity.type, 'vehicle');
    expect(t.dates.map((d) => d.kind), ['service', 'inspection']);
    expect(notifications.scheduled.values.map((n) => n.at).toSet(), {DateTime(2027, 4, 10, 9), DateTime(2026, 10, 25, 9)});
  });

  test('people and things lists are separate, and document entities stay out', () async {
    await repo.addPerson(name: 'Elif', relation: 'child');
    await repo.addThing(name: 'Ev', type: 'home');
    await db.into(db.entities).insert(EntitiesCompanion.insert(
        id: 'doc-entity', source: Source.document, createdAt: now, updatedAt: now, type: 'insurance', displayName: 'Kasko'));
    expect((await repo.watchPeople().first).map((e) => e.entity.displayName), ['Elif']);
    expect((await repo.watchThings().first).map((e) => e.entity.displayName), ['Ev']);
  });

  test('delete removes dates, reminders and relationships', () async {
    final id = await repo.addPerson(name: 'Elif', relation: 'child', birthday: DateTime(2018, 10, 4));
    await repo.delete(id);
    expect(await db.select(db.entities).get(), isEmpty);
    expect(await db.select(db.entityDates).get(), isEmpty);
    expect(await db.select(db.reminders).get(), isEmpty);
    expect(notifications.scheduled, isEmpty);
    expect((await db.select(db.auditLogs).get()).last.action, 'person_deleted');
  });

  test('a name is required', () {
    expect(() => repo.addPerson(name: '  ', relation: 'friend'), throwsArgumentError);
  });

  test('related items find memories, tasks and documents by name, Turkish-aware', () async {
    final memories = MemoryRepository(db, clock: () => now);
    await memories.remember(const MemoryDraft(content: 'ELİF okulda satranç kulübüne başladı', category: 'family'));
    await memories.remember(const MemoryDraft(content: 'Arabam BYD Seal U', category: 'vehicle'));
    await planner.createTask(const TaskDraft(title: "Elif'in veli toplantısı"));
    final r = await repo.related('elif');
    expect(r.memories.single.content, contains('satranç'));
    expect(r.tasks.single.title, contains('veli'));
    expect(r.documents, isEmpty);
  });

  test('timeline mixes what is coming and what happened, newest first', () async {
    await repo.addPerson(name: 'Elif', relation: 'child', birthday: DateTime(2018, 10, 4));
    await planner.createTask(TaskDraft(title: 'Sigortayı ara', due: DateTime(2026, 9, 25, 9)));
    final done = await planner.createTask(TaskDraft(title: 'Faturayı öde', due: DateTime(2026, 9, 23, 9)));
    await planner.completeTask(done);
    await planner.createEvent(EventDraft(title: 'Dişçi', startsAt: DateTime(2026, 9, 30, 15)));
    await MemoryRepository(db, clock: () => now).remember(const MemoryDraft(content: 'Sabah uçuşlarını severim', category: 'preference'));

    final items = await repo.timeline();
    expect(items.map((i) => '${i.kind.name}:${i.title}'), [
      'date:Elif',
      'event:Dişçi',
      'taskDue:Sigortayı ara',
      'taskDone:Faturayı öde',
      'memory:Sabah uçuşlarını severim',
    ]);
    expect(items.first.detail, 'birthday');
    expect(items.first.route, startsWith('/life/'));
  });
}
