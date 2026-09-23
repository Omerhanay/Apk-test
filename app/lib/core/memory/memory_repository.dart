import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/database.dart';
import '../text/search_fold.dart';

/// Categories shared with the relay's memory parser (relay/src/llm/types.ts).
const memoryCategories = [
  'family', 'vehicle', 'home', 'health', 'work', 'finance', 'travel', 'preference', 'routine', 'other',
];

/// Default sensitivity when the user files a memory by hand.
Sensitivity sensitivityForCategory(String category) => switch (category) {
      'health' => Sensitivity.specialCategory,
      'finance' => Sensitivity.sensitive,
      'family' => Sensitivity.personal,
      _ => Sensitivity.normal,
    };

class MemoryDraft {
  const MemoryDraft({
    required this.content,
    required this.category,
    this.kind = MemoryKind.semantic,
    this.subject,
    this.predicate,
    this.value,
    this.validUntil,
    Sensitivity? sensitivity,
    this.confidence = 1.0,
    this.source = Source.userStated,
    this.sourceRef,
  }) : sensitivity = sensitivity ?? Sensitivity.normal;

  final String content;
  final String category;
  final MemoryKind kind;

  /// With [predicate], identifies the fact so a newer statement replaces it.
  final String? subject;
  final String? predicate;
  final String? value;
  final DateTime? validUntil;
  final Sensitivity sensitivity;
  final double confidence;
  final Source source;
  final String? sourceRef;

  bool get hasKey => subject != null && predicate != null;
}

class MemoryWriteResult {
  const MemoryWriteResult(this.id, this.supersededIds);
  final String id;
  final List<String> supersededIds;
}

/// An AI-inferred fact contradicted something the user said. The user wins;
/// nothing is written.
class MemoryConflict implements Exception {
  const MemoryConflict(this.existingId);
  final String existingId;
}

/// One step in a memory's history, newest first.
class MemoryHistoryEntry {
  const MemoryHistoryEntry({required this.at, required this.content, required this.reason});
  final DateTime at;
  final String content;

  /// edited | superseded | retracted
  final String reason;
}

/// All reads and writes of memories. Facts are never overwritten in place
/// without keeping the previous state, and every change is audited by id only.
class MemoryRepository {
  MemoryRepository(this._db, {DateTime Function()? clock, String Function()? newId})
      : _now = clock ?? DateTime.now,
        _newId = newId ?? const Uuid().v7;

  final LifeDatabase _db;
  final DateTime Function() _now;
  final String Function() _newId;

  Expression<bool> _isActive($MemoriesTable m, DateTime now) =>
      m.deletedAt.isNull() & m.supersededBy.isNull() & (m.validTo.isNull() | m.validTo.isBiggerThanValue(now));

  Stream<List<Memory>> watchActive() {
    final now = _now();
    return (_db.select(_db.memories)
          ..where((m) => _isActive(m, now))
          ..orderBy([(m) => OrderingTerm.desc(m.updatedAt)]))
        .watch();
  }

  Future<Memory?> byId(String id) => (_db.select(_db.memories)..where((m) => m.id.equals(id))).getSingleOrNull();

  Stream<Memory?> watchById(String id) => (_db.select(_db.memories)..where((m) => m.id.equals(id))).watchSingleOrNull();

  /// Active facts with this key (normally zero or one).
  Future<List<Memory>> activeByKey(String subject, String predicate) {
    final now = _now();
    return (_db.select(_db.memories)
          ..where((m) => _isActive(m, now) & m.subject.equals(subject) & m.predicate.equals(predicate)))
        .get();
  }

  /// Keys of active facts, sent to the relay so corrections reuse them.
  Future<List<({String subject, String predicate})>> knownSubjects() async {
    final now = _now();
    final rows = await (_db.select(_db.memories)
          ..where((m) => _isActive(m, now) & m.subject.isNotNull() & m.predicate.isNotNull()))
        .get();
    return {for (final r in rows) (subject: r.subject!, predicate: r.predicate!)}.toList();
  }

  /// Stores a memory. A keyed fact replaces the active fact with the same key,
  /// which is closed and kept as history.
  Future<MemoryWriteResult> remember(MemoryDraft d, {String actor = 'user'}) {
    return _db.transaction(() async {
      final now = _now();
      final id = _newId();
      final previous = d.hasKey ? await activeByKey(d.subject!, d.predicate!) : const <Memory>[];

      if (d.source == Source.aiInferred) {
        final userStated = previous.where((p) => p.source == Source.userStated);
        if (userStated.isNotEmpty) throw MemoryConflict(userStated.first.id);
      }

      await _db.into(_db.memories).insert(MemoriesCompanion.insert(
            id: id,
            source: d.source,
            sourceRef: Value(d.sourceRef),
            confidence: Value(d.confidence),
            sensitivity: Value(d.sensitivity),
            createdAt: now,
            updatedAt: now,
            kind: d.kind,
            category: d.category,
            content: d.content.trim(),
            subject: Value(d.subject),
            predicate: Value(d.predicate),
            value: Value(d.value),
            validFrom: now,
            validTo: Value(d.validUntil),
          ));

      // The replaced row keeps its content and is linked to its successor;
      // history() walks that chain.
      for (final old in previous) {
        await (_db.update(_db.memories)..where((m) => m.id.equals(old.id))).write(MemoriesCompanion(
          validTo: Value(now),
          supersededBy: Value(id),
          updatedAt: Value(now),
        ));
        await _audit(actor, 'memory_superseded', old.id);
      }
      await _audit(actor, 'memory_created', id);
      return MemoryWriteResult(id, [for (final p in previous) p.id]);
    });
  }

  /// Marks facts as no longer true, by id or by key. Returns the affected ids;
  /// empty means nothing matched and nothing changed.
  Future<List<String>> retract({String? id, String? subject, String? predicate, String actor = 'user'}) {
    return _db.transaction(() async {
      final now = _now();
      final targets = <Memory>[
        if (id != null) ...[?await byId(id)],
        if (id == null && subject != null && predicate != null) ...await activeByKey(subject, predicate),
      ].where((m) => m.deletedAt == null && m.supersededBy == null && (m.validTo == null || m.validTo!.isAfter(now)));

      final ids = <String>[];
      for (final m in targets) {
        await _snapshot(m, changedBy: actor, reason: 'retracted');
        await (_db.update(_db.memories)..where((r) => r.id.equals(m.id)))
            .write(MemoriesCompanion(validTo: Value(now), updatedAt: Value(now), version: Value(m.version + 1)));
        await _audit(actor, 'memory_retracted', m.id);
        ids.add(m.id);
      }
      return ids;
    });
  }

  /// Edits a memory in place, keeping the previous text in its history.
  Future<void> edit(String id, {String? content, String? category, String actor = 'user'}) {
    return _db.transaction(() async {
      final m = await byId(id);
      if (m == null || m.deletedAt != null) throw StateError('Unknown memory');
      if (!m.userEditable) throw StateError('Memory is not editable');
      await _snapshot(m, changedBy: actor, reason: 'edited');
      await (_db.update(_db.memories)..where((r) => r.id.equals(id))).write(MemoriesCompanion(
        content: content == null ? const Value.absent() : Value(content.trim()),
        category: category == null ? const Value.absent() : Value(category),
        updatedAt: Value(_now()),
        version: Value(m.version + 1),
      ));
      await _audit(actor, 'memory_edited', id);
    });
  }

  /// Permanently removes a memory, its edit history and the facts it replaced.
  Future<void> delete(String id) {
    return _db.transaction(() async {
      if (await byId(id) == null) throw StateError('Unknown memory');
      final chain = await _chain(id);
      // Oldest first: each replaced fact references its successor.
      for (final current in chain.reversed) {
        await (_db.delete(_db.memoryVersions)..where((v) => v.memoryId.equals(current))).go();
        await (_db.delete(_db.memories)..where((m) => m.id.equals(current))).go();
      }
      await _audit('user', 'memory_deleted', id);
    });
  }

  /// [id] followed by every fact it (transitively) replaced.
  Future<List<String>> _chain(String id) async {
    final chain = <String>[];
    var frontier = [id];
    while (frontier.isNotEmpty && chain.length < 500) {
      chain.addAll(frontier);
      final replaced = await (_db.select(_db.memories)..where((m) => m.supersededBy.isIn(frontier))).get();
      frontier = [for (final r in replaced) if (!chain.contains(r.id)) r.id];
    }
    return chain;
  }

  /// Earlier states of this memory and of the facts it replaced, newest first.
  Future<List<MemoryHistoryEntry>> history(String id) async {
    final entries = <MemoryHistoryEntry>[];
    final seen = <String>{};
    var ids = [id];
    // Walk back through replaced facts; bounded in case of a corrupted cycle.
    for (var depth = 0; ids.isNotEmpty && depth < 50; depth++) {
      final next = <String>[];
      for (final current in ids) {
        if (!seen.add(current)) continue;
        final versions = await (_db.select(_db.memoryVersions)..where((v) => v.memoryId.equals(current))).get();
        entries.addAll(versions.map((v) => MemoryHistoryEntry(at: v.at, content: v.content, reason: v.changeReason ?? 'edited')));
        final replaced = await (_db.select(_db.memories)..where((m) => m.supersededBy.equals(current))).get();
        for (final r in replaced) {
          entries.add(MemoryHistoryEntry(at: r.validTo ?? r.updatedAt, content: r.content, reason: 'superseded'));
          next.add(r.id);
        }
      }
      ids = next;
    }
    return entries..sort((a, b) => b.at.compareTo(a.at));
  }

  /// Forgiving local search: every term must appear in the content, category or
  /// value, compared with Turkish-aware folding.
  Future<List<Memory>> search(String query, {String? category, bool includeHistory = false, int limit = 20}) async {
    final terms = searchTerms(query);
    final now = _now();
    final rows = await (_db.select(_db.memories)
          ..where((m) => m.deletedAt.isNull())
          ..where((m) => includeHistory ? const Constant(true) : _isActive(m, now))
          ..where((m) => category == null ? const Constant(true) : m.category.equals(category))
          ..orderBy([(m) => OrderingTerm.desc(m.updatedAt)]))
        .get();
    if (terms.isEmpty) return rows.take(limit).toList();
    return rows
        .where((m) {
          final haystack = foldForSearch('${m.content} ${m.category} ${m.value ?? ''}');
          return terms.every(haystack.contains);
        })
        .take(limit)
        .toList();
  }

  Future<void> _snapshot(Memory m, {required String changedBy, required String reason}) {
    return _db.into(_db.memoryVersions).insert(MemoryVersionsCompanion.insert(
          memoryId: m.id,
          version: m.version,
          content: m.content,
          value: Value(m.value),
          validTo: Value(m.validTo),
          changedBy: changedBy,
          changeReason: Value(reason),
          at: _now(),
        ));
  }

  Future<void> _audit(String actor, String action, String id) =>
      _db.audit(actor: actor, action: action, outcome: 'ok', targetType: 'memory', targetId: id, at: _now());
}
