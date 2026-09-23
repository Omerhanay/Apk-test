import 'dart:convert';

import '../db/database.dart';
import 'planner_repository.dart';

/// Executes the task, event and reminder tools from `contracts/agent-tools.json`
/// on device, after the permission firewall has allowed the call.
class PlannerTools {
  PlannerTools(this._repo);
  final PlannerRepository _repo;

  Future<String> searchTasks(Map<String, dynamic> input) async {
    final tasks = await _repo.searchTasks(
      query: input['query'] as String?,
      status: input['status'] as String? ?? 'open',
      dueAfter: DateTime.tryParse(input['due_after'] as String? ?? ''),
      dueBefore: DateTime.tryParse(input['due_before'] as String? ?? ''),
    );
    return jsonEncode([
      for (final t in tasks.take(50))
        {
          'id': t.id,
          'title': t.title,
          'status': t.status.name,
          'priority': t.priority.name,
          if (t.dueAt != null) 'due_at': t.dueAt!.toIso8601String(),
          if (t.allDay) 'all_day': true,
          if (t.recurrenceRule != null) 'repeats': t.recurrenceRule,
        },
    ]);
  }

  Future<String> searchEvents(Map<String, dynamic> input) async {
    final events = await _repo.searchEvents(
      query: input['query'] as String?,
      start: DateTime.parse(input['start'] as String),
      end: DateTime.parse(input['end'] as String),
    );
    return jsonEncode([
      for (final e in events.take(50))
        {
          'id': e.id,
          'title': e.title,
          'starts_at': e.startsAt.toIso8601String(),
          if (e.endsAt != null) 'ends_at': e.endsAt!.toIso8601String(),
          if (e.location != null) 'location': e.location,
        },
    ]);
  }

  Future<String> createTask(Map<String, dynamic> input, {required String runId}) async {
    final id = await _repo.createTask(
      TaskDraft(
        title: input['title'] as String,
        notes: input['notes'] as String?,
        due: DateTime.tryParse(input['due_at'] as String? ?? ''),
        priority: Priority.values.asNameMap()[input['priority']] ?? Priority.normal,
        source: Source.aiInferred,
        sourceRef: runId,
      ),
      actor: 'agent',
    );
    return jsonEncode({'status': 'created', 'id': id});
  }

  Future<String> createEvent(Map<String, dynamic> input, {required String runId}) async {
    try {
      final id = await _repo.createEvent(
        EventDraft(
          title: input['title'] as String,
          startsAt: DateTime.parse(input['starts_at'] as String),
          endsAt: DateTime.tryParse(input['ends_at'] as String? ?? ''),
          location: input['location'] as String?,
          source: Source.aiInferred,
          sourceRef: runId,
        ),
        actor: 'agent',
      );
      return jsonEncode({'status': 'created', 'id': id});
    } on ArgumentError {
      return jsonEncode({'status': 'failed', 'error': 'ends_before_start'});
    }
  }

  Future<String> createReminder(Map<String, dynamic> input, {required String runId}) async {
    final id = await _repo.createReminder(
      title: input['title'] as String,
      fireAt: DateTime.parse(input['fire_at'] as String),
      targetId: input['target_id'] as String?,
      actor: 'agent',
    );
    return jsonEncode({'status': 'created', 'id': id});
  }
}
