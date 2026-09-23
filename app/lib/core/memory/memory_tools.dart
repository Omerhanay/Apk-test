import 'dart:convert';

import '../db/database.dart';
import 'memory_repository.dart';

/// Executes the memory tools from `contracts/agent-tools.json` on device.
///
/// These run only after the permission firewall has allowed the call (and, for
/// commits, after the user approved it). Results are JSON strings returned to
/// the model; commit results report exactly what happened.
class MemoryTools {
  MemoryTools(this._repo);
  final MemoryRepository _repo;

  static const _maxResults = 20;

  Future<String> searchMemory(Map<String, dynamic> input) async {
    final results = await _repo.search(
      input['query'] as String,
      category: input['category'] as String?,
      includeHistory: input['include_history'] == true,
      limit: _maxResults,
    );
    return jsonEncode([
      for (final m in results)
        {
          'id': m.id,
          'content': m.content,
          'category': m.category,
          'kind': m.kind.name,
          'source': m.source.name,
          'recorded_at': m.createdAt.toIso8601String(),
          if (m.validTo != null) 'valid_until': m.validTo!.toIso8601String(),
          if (m.supersededBy != null) 'replaced_by': m.supersededBy,
        },
    ]);
  }

  /// [runId] links AI-written memories to the agent run that produced them.
  Future<String> updateMemory(Map<String, dynamic> input, {required String runId}) async {
    final op = input['op'] as String;
    final memoryId = input['memory_id'] as String?;
    final content = (input['content'] as String?)?.trim();

    switch (op) {
      case 'create':
        if (content == null || content.isEmpty) return _result('failed', error: 'content_required');
        final category = input['category'] as String? ?? 'other';
        try {
          final result = await _repo.remember(
            MemoryDraft(
              content: content,
              category: memoryCategories.contains(category) ? category : 'other',
              kind: MemoryKind.values.asNameMap()[input['kind']] ?? MemoryKind.semantic,
              validUntil: DateTime.tryParse(input['valid_until'] as String? ?? ''),
              sensitivity: sensitivityForCategory(category),
              // The model wrote this; it never outranks what the user said directly.
              source: Source.aiInferred,
              confidence: 0.7,
              sourceRef: runId,
            ),
            actor: 'agent',
          );
          return _result('created', id: result.id);
        } on MemoryConflict catch (c) {
          return _result('conflict_with_user_stated', id: c.existingId);
        }
      case 'update':
        if (memoryId == null || content == null || content.isEmpty) return _result('failed', error: 'memory_id_and_content_required');
        if (await _repo.byId(memoryId) == null) return _result('failed', error: 'not_found');
        await _repo.edit(memoryId, content: content, actor: 'agent');
        return _result('updated', id: memoryId);
      case 'retract':
        if (memoryId == null) return _result('failed', error: 'memory_id_required');
        final ids = await _repo.retract(id: memoryId, actor: 'agent');
        return ids.isEmpty ? _result('failed', error: 'not_found_or_already_inactive') : _result('retracted', id: memoryId);
      default:
        return _result('failed', error: 'unknown_op');
    }
  }

  String _result(String status, {String? id, String? error}) =>
      jsonEncode({'status': status, 'id': ?id, 'error': ?error});
}
