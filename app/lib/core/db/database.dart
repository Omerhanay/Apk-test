import 'package:drift/drift.dart';

import 'tables.dart';

export 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Memories,
  MemoryVersions,
  Entities,
  EntityRelationships,
  EntityDates,
  Documents,
  DocumentExtractions,
  DocumentChunks,
  Tasks,
  Events,
  Reminders,
  Commitments,
  Permissions,
  AgentRuns,
  AgentActions,
  Suggestions,
  AuditLogs,
  EmergencyFields,
])
class LifeDatabase extends _$LifeDatabase {
  LifeDatabase(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          for (final stmt in _indexes) {
            await customStatement(stmt);
          }
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );

  static const _indexes = [
    'CREATE INDEX idx_memories_active ON memories (subject, predicate) WHERE valid_to IS NULL AND deleted_at IS NULL',
    'CREATE INDEX idx_entity_dates_date ON entity_dates (date) WHERE deleted_at IS NULL',
    'CREATE INDEX idx_tasks_due ON tasks (status, due_at) WHERE deleted_at IS NULL',
    'CREATE INDEX idx_events_start ON events (starts_at) WHERE deleted_at IS NULL',
    'CREATE INDEX idx_reminders_fire ON reminders (status, fire_at) WHERE deleted_at IS NULL',
    'CREATE INDEX idx_actions_state ON agent_actions (state)',
    'CREATE INDEX idx_audit_at ON audit_logs (at)',
  ];

  /// Appends an audit entry. Callers pass ids and outcome codes only.
  Future<void> audit({
    required String actor,
    required String action,
    required String outcome,
    String? targetType,
    String? targetId,
    DateTime? at,
  }) {
    return into(auditLogs).insert(AuditLogsCompanion.insert(
      actor: actor,
      action: action,
      outcome: outcome,
      targetType: Value(targetType),
      targetId: Value(targetId),
      at: at ?? DateTime.now(),
    ));
  }
}
