import 'dart:convert';

import '../db/database.dart';
import 'document_repository.dart';

/// Executes `search_documents` on device. Local-only documents (identity,
/// health) are listed by name and type only; their text and fields are never
/// placed in a model's context.
class DocumentTools {
  DocumentTools(this._repo);
  final DocumentRepository _repo;

  Future<String> searchDocuments(Map<String, dynamic> input) async {
    final docs = await _repo.search(input['query'] as String, docType: input['doc_type'] as String?, limit: 10);
    final out = <Map<String, Object?>>[];
    for (final d in docs) {
      final shareable = DocumentRepository.mayUseAi(d);
      final List<DocumentExtraction> fields = shareable ? await _repo.extractions(d.id) : const [];
      out.add({
        'id': d.id,
        'name': d.title ?? d.fileName,
        'type': d.docType,
        'added_at': d.createdAt.toIso8601String(),
        if (!shareable) 'note': 'local-only document: contents are not shared',
        if (shareable)
          'fields': {
            for (final f in fields.where((f) => f.reviewStatus == ReviewStatus.accepted || f.reviewStatus == ReviewStatus.edited))
              f.field: f.value,
          },
      });
    }
    return jsonEncode(out);
  }
}
