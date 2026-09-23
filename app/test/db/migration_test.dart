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
    expect((await db.customSelect('PRAGMA user_version').getSingle()).read<int>('user_version'), 3);

    // The new column is writable.
    await (db.update(db.tasks)..where((t) => t.id.equals('t1'))).write(const TasksCompanion(allDay: Value(true)));
    expect((await db.select(db.tasks).getSingle()).allDay, isTrue);
  });
  test('v2 → v3 adds document title and extraction provenance', () async {
    final dir = await Directory.systemTemp.createTemp('lifeos_mig3');
    addTearDown(() => dir.delete(recursive: true));
    final file = File('${dir.path}/v2.db');
    final v2 = raw.sqlite3.open(file.path);
    v2.execute(File('test/db/fixtures/schema_v2.sql').readAsStringSync());
    v2.execute("INSERT INTO documents (id, source, created_at, updated_at, file_name, mime_type, sha256, size_bytes, blob_path) "
        "VALUES ('d1', 1, 0, 0, 'kasko.pdf', 'application/pdf', 'abc', 10, 'x.bin')");
    v2.execute("INSERT INTO document_extractions (id, document_id, field, value, confidence) VALUES ('e1', 'd1', 'expires_on', '2027-05-10', 0.8)");
    v2.close();

    final db = LifeDatabase(NativeDatabase(file));
    addTearDown(db.close);
    final doc = await db.select(db.documents).getSingle();
    expect(doc.fileName, 'kasko.pdf');
    expect(doc.title, isNull);
    final ex = await db.select(db.documentExtractions).getSingle();
    expect(ex.origin, 'local', reason: 'existing rows get the default');
    expect(ex.quote, isNull);
    final indexes = await db.customSelect("SELECT name FROM sqlite_master WHERE type = 'index' AND name = 'idx_chunks_document'").get();
    expect(indexes, hasLength(1));
  });
}
