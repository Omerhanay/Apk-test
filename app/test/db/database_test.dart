import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';

void main() {
  test('schema creates and supports a memory correction with history', () async {
    final db = LifeDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final t0 = DateTime.utc(2026, 9, 1);
    final t1 = DateTime.utc(2026, 9, 22);

    MemoriesCompanion fact(String id, String value, DateTime at) => MemoriesCompanion.insert(
          id: id,
          source: Source.userStated,
          createdAt: at,
          updatedAt: at,
          kind: MemoryKind.semantic,
          category: 'vehicle',
          content: 'My car is a $value',
          subject: const Value('user.vehicle'),
          predicate: const Value('model'),
          value: Value(value),
          validFrom: at,
        );

    await db.into(db.memories).insert(fact('m1', 'Model A', t0));
    await db.transaction(() async {
      await db.into(db.memories).insert(fact('m2', 'Model B', t1));
      await (db.update(db.memories)..where((m) => m.id.equals('m1')))
          .write(MemoriesCompanion(validTo: Value(t1), supersededBy: const Value('m2')));
      await db.into(db.memoryVersions).insert(MemoryVersionsCompanion.insert(
            memoryId: 'm1', version: 1, content: 'My car is a Model A', changedBy: 'user', at: t1));
    });

    final active = await (db.select(db.memories)
          ..where((m) => m.subject.equals('user.vehicle') & m.validTo.isNull()))
        .get();
    expect(active.map((m) => m.value), ['Model B']);
    expect(await db.select(db.memories).get(), hasLength(2), reason: 'history is kept, not deleted');
  });

  test('foreign keys are enforced', () async {
    final db = LifeDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    final now = DateTime.utc(2026, 9, 22);
    expect(
      () => db.into(db.entityDates).insert(EntityDatesCompanion.insert(
            id: 'd1', source: Source.document, createdAt: now, updatedAt: now,
            entityId: 'missing', kind: 'expires', date: now)),
      throwsA(isA<SqliteException>()),
    );
  });

  test('audit log stores references only', () async {
    final db = LifeDatabase(NativeDatabase.memory());
    addTearDown(db.close);
    await db.audit(actor: 'agent', action: 'create_task', outcome: 'blocked', targetType: 'agent_action', targetId: 'a1');
    final row = await db.select(db.auditLogs).getSingle();
    expect(row.outcome, 'blocked');
  });

  test('database file is encrypted at rest and unreadable without the key', () async {
    final dir = await Directory.systemTemp.createTemp('lifeos');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/enc.db');
    const key = '00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff';
    const marker = 'plaintext-marker-4e1b';

    final db = LifeDatabase(NativeDatabase(file, setup: (raw) => raw.execute("PRAGMA key = \"x'$key'\"")));
    await db.audit(actor: 'user', action: marker, outcome: 'ok');
    await db.close();

    final bytes = await file.readAsBytes();
    expect(String.fromCharCodes(bytes).contains(marker), isFalse);
    expect(String.fromCharCodes(bytes.take(15)), isNot('SQLite format 3'));

    final noKey = LifeDatabase(NativeDatabase(file));
    await expectLater(noKey.select(noKey.auditLogs).get(), throwsA(anything));
    await noKey.close();

    final reopened = LifeDatabase(NativeDatabase(file, setup: (raw) => raw.execute("PRAGMA key = \"x'$key'\"")));
    expect((await reopened.select(reopened.auditLogs).getSingle()).action, marker);
    await reopened.close();
  });
}
