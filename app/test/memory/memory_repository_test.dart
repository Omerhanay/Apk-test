import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/memory/memory_repository.dart';
import 'package:life_os/core/memory/memory_tools.dart';
import 'package:life_os/core/text/search_fold.dart';

void main() {
  late LifeDatabase db;
  late MemoryRepository repo;
  late DateTime now;
  var n = 0;

  setUp(() {
    db = LifeDatabase(NativeDatabase.memory());
    now = DateTime(2026, 9, 22, 9);
    repo = MemoryRepository(db, clock: () => now, newId: () => 'm${++n}');
  });
  tearDown(() => db.close());

  void tick() => now = now.add(const Duration(minutes: 1));
  Future<List<Memory>> active() => repo.watchActive().first;
  Future<List<String>> audit() async => [for (final a in await db.select(db.auditLogs).get()) '${a.action}:${a.targetId}'];

  const car = MemoryDraft(
    content: 'My car is a BYD Seal U',
    category: 'vehicle',
    subject: 'user.vehicle',
    predicate: 'model',
    value: 'BYD Seal U',
  );

  group('foldForSearch', () {
    test('treats every Turkish i form as the same letter', () {
      expect(foldForSearch('İSTANBUL'), 'istanbul');
      expect(foldForSearch('ILIK'), foldForSearch('ılık'));
      expect(foldForSearch('İstanbul'.toLowerCase()), 'istanbul', reason: 'strips the combining dot');
    });

    test('ignores Turkish diacritics', () {
      expect(foldForSearch('POLİÇE'), 'police');
      expect(foldForSearch('Doğum günü'), 'dogum gunu');
    });
  });

  test('a newer statement about the same thing replaces the old one and keeps it as history', () async {
    final first = await repo.remember(car);
    tick();
    final second = await repo.remember(const MemoryDraft(
      content: 'My car is a Tesla Model Y',
      category: 'vehicle',
      subject: 'user.vehicle',
      predicate: 'model',
      value: 'Tesla Model Y',
    ));

    expect(second.supersededIds, [first.id]);
    expect((await active()).map((m) => m.content), ['My car is a Tesla Model Y']);

    final old = (await repo.byId(first.id))!;
    expect(old.supersededBy, second.id);
    expect(old.validTo, now);

    final history = await repo.history(second.id);
    expect(history.map((h) => '${h.reason}:${h.content}'), ['superseded:My car is a BYD Seal U']);
    expect(await audit(), contains('memory_superseded:${first.id}'));
  });

  test('unkeyed memories never replace each other', () async {
    await repo.remember(const MemoryDraft(content: 'I prefer morning flights', category: 'preference'));
    await repo.remember(const MemoryDraft(content: 'The garage is closed on Sundays', category: 'vehicle'));
    expect(await active(), hasLength(2));
  });

  test('retracting marks a fact no longer true without deleting it', () async {
    final m = await repo.remember(car);
    tick();
    expect(await repo.retract(subject: 'user.vehicle', predicate: 'model'), [m.id]);
    expect(await active(), isEmpty);
    expect((await repo.byId(m.id))!.validTo, now);
    expect((await repo.history(m.id)).single.reason, 'retracted');
    expect(await repo.retract(subject: 'user.vehicle', predicate: 'model'), isEmpty, reason: 'already inactive');
  });

  test('editing keeps the previous text', () async {
    final m = await repo.remember(const MemoryDraft(content: 'Garage closed Sunday', category: 'vehicle'));
    tick();
    await repo.edit(m.id, content: 'The garage is closed on Sundays and Mondays');
    final row = (await repo.byId(m.id))!;
    expect(row.content, 'The garage is closed on Sundays and Mondays');
    expect(row.version, 2);
    expect((await repo.history(m.id)).single.content, 'Garage closed Sunday');
  });

  test('a fact with a future end date stays active until then', () async {
    await repo.remember(MemoryDraft(content: 'Staying in Izmir', category: 'travel', validUntil: now.add(const Duration(days: 2))));
    expect(await active(), hasLength(1));
    now = now.add(const Duration(days: 3));
    expect(await MemoryRepository(db, clock: () => now).watchActive().first, isEmpty);
  });

  test('delete removes the memory, its edits and the facts it replaced', () async {
    final a = await repo.remember(car);
    tick();
    await repo.edit(a.id, content: 'My car is a BYD Seal U (white)');
    tick();
    final b = await repo.remember(car);
    await repo.delete(b.id);

    expect(await db.select(db.memories).get(), isEmpty);
    expect(await db.select(db.memoryVersions).get(), isEmpty);
    final log = await audit();
    expect(log.last, 'memory_deleted:${b.id}');
    expect((await db.select(db.auditLogs).get()).any((e) => e.action.contains('BYD')), isFalse);
  });

  test('search matches Turkish text regardless of case and diacritics', () async {
    await repo.remember(const MemoryDraft(content: 'Kasko poliçem Anadolu Sigorta\'da', category: 'vehicle'));
    await repo.remember(const MemoryDraft(content: 'İstanbul\'da yaşıyorum', category: 'home'));
    await repo.remember(const MemoryDraft(content: 'I prefer morning flights', category: 'preference'));

    expect((await repo.search('POLİÇE')).single.content, contains('poliçem'));
    expect((await repo.search('istanbul')).single.category, 'home');
    expect((await repo.search('morning flights')).single.category, 'preference');
    expect(await repo.search('evening flights'), isEmpty, reason: 'every term must match');
    expect(await repo.search('flights', category: 'home'), isEmpty);
  });

  test('history search includes replaced facts only when asked', () async {
    await repo.remember(car);
    tick();
    await repo.remember(const MemoryDraft(
        content: 'My car is a Tesla Model Y', category: 'vehicle', subject: 'user.vehicle', predicate: 'model'));
    expect(await repo.search('BYD'), isEmpty);
    expect(await repo.search('BYD', includeHistory: true), hasLength(1));
  });

  test('knownSubjects returns keys only', () async {
    await repo.remember(car);
    expect(await repo.knownSubjects(), [(subject: 'user.vehicle', predicate: 'model')]);
  });

  group('what the user said outranks the AI', () {
    test('an AI-inferred fact cannot replace a user-stated one', () async {
      final mine = await repo.remember(car);
      await expectLater(
        repo.remember(const MemoryDraft(
          content: 'The car is a Tesla',
          category: 'vehicle',
          subject: 'user.vehicle',
          predicate: 'model',
          source: Source.aiInferred,
        )),
        throwsA(isA<MemoryConflict>().having((c) => c.existingId, 'existingId', mine.id)),
      );
      expect((await active()).single.id, mine.id);
    });

    test('the user can replace an AI-inferred fact', () async {
      await repo.remember(const MemoryDraft(
          content: 'Car: Tesla', category: 'vehicle', subject: 'user.vehicle', predicate: 'model', source: Source.aiInferred));
      final mine = await repo.remember(car);
      expect((await active()).single.id, mine.id);
    });
  });

  group('memory tools', () {
    late MemoryTools tools;
    setUp(() => tools = MemoryTools(repo));

    test('search returns ids to cite and no deleted data', () async {
      final m = await repo.remember(car);
      final results = jsonDecode(await tools.searchMemory({'query': 'byd'})) as List;
      expect(results.single['id'], m.id);
      expect(results.single['source'], 'userStated');

      await repo.delete(m.id);
      expect(jsonDecode(await tools.searchMemory({'query': 'byd'})), isEmpty);
    });

    test('create stores an AI-sourced memory linked to the run', () async {
      final out = jsonDecode(await tools.updateMemory({'op': 'create', 'content': 'Prefers aisle seats', 'category': 'preference'}, runId: 'run1'));
      expect(out['status'], 'created');
      final row = (await repo.byId(out['id'] as String))!;
      expect(row.source, Source.aiInferred);
      expect(row.sourceRef, 'run1');
    });

    test('create with a health category is stored as special-category data', () async {
      final out = jsonDecode(await tools.updateMemory({'op': 'create', 'content': 'Allergic to penicillin', 'category': 'health'}, runId: 'r'));
      expect((await repo.byId(out['id'] as String))!.sensitivity, Sensitivity.specialCategory);
    });

    test('retract and update report what really happened', () async {
      final m = await repo.remember(car);
      expect(jsonDecode(await tools.updateMemory({'op': 'retract', 'memory_id': 'nope'}, runId: 'r'))['status'], 'failed');
      expect(jsonDecode(await tools.updateMemory({'op': 'retract', 'memory_id': m.id}, runId: 'r'))['status'], 'retracted');
      expect(jsonDecode(await tools.updateMemory({'op': 'retract', 'memory_id': m.id}, runId: 'r'))['status'], 'failed',
          reason: 'already retracted');
      expect(jsonDecode(await tools.updateMemory({'op': 'update', 'memory_id': m.id}, runId: 'r'))['status'], 'failed');
    });
  });
}
