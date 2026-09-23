import 'dart:io';

import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:sqlite3/sqlite3.dart' as raw;

void main() {
  test('v1 → v2 adds tasks.all_day and keeps existing rows', () async {
    final dir = await Directory.systemTemp.createTemp('lifeos_mig');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/v1.db');

    // A real v1 database, created from the schema v1 shipped with.
    final v1 = raw.sqlite3.open(file.path);
    v1.execute(File('test/db/fixtures/schema_v1.sql').readAsStringSync());
    v1.execute("INSERT INTO tasks (id, source, created_at, updated_at, title, status, priority) "
        "VALUES ('t1', 0, 0, 0, 'Renew insurance', 0, 1)");
    v1.close();

    final db = LifeDatabase(NativeDatabase(file));
    addTearDown(db.close);
    final task = await (db.select(db.tasks)..where((t) => t.id.equals('t1'))).getSingle();
    expect(task.title, 'Renew insurance');
    expect(task.allDay, isFalse);
    expect((await db.customSelect('PRAGMA user_version').getSingle()).read<int>('user_version'), 2);

    // The new column is writable.
    await (db.update(db.tasks)..where((t) => t.id.equals('t1'))).write(const TasksCompanion(allDay: Value(true)));
    expect((await db.select(db.tasks).getSingle()).allDay, isTrue);
  });
}
