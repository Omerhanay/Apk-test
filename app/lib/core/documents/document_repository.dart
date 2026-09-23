import 'dart:convert';

import 'package:crypto/crypto.dart' show sha256;
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/database.dart';
import '../planner/planner_repository.dart';
import '../text/search_fold.dart';
import 'blob_store.dart';
import 'classifier.dart';
import 'field_extractor.dart';
import 'text_extractor.dart';

class ImportResult {
  const ImportResult(this.id, {required this.duplicate});
  final String id;

  /// The same file was already stored; nothing new was written.
  final bool duplicate;
}

/// A reviewed date that became a reminder.
class ConfirmedDate {
  const ConfirmedDate({required this.kind, required this.date, this.reminderAt});
  final String kind;
  final DateTime date;
  final DateTime? reminderAt;
}

/// Documents: encrypted files plus their text, type and extracted fields.
///
/// Import reads and classifies the document on the device and proposes fields;
/// nothing becomes an entity, date or reminder until the user confirms the
/// review. Every change is audited by id only.
class DocumentRepository {
  DocumentRepository(
    this._db,
    this._blobs,
    this._text,
    this._planner, {
    DateTime Function()? clock,
    String Function()? newId,
  })  : _now = clock ?? DateTime.now,
        _newId = newId ?? const Uuid().v7;

  final LifeDatabase _db;
  final BlobStore _blobs;
  final TextExtractor _text;
  final PlannerRepository _planner;
  final DateTime Function() _now;
  final String Function() _newId;
  static const _extractor = FieldExtractor();

  static const supportedMimeTypes = {'application/pdf', 'image/jpeg', 'image/png'};
  static const maxBytes = 25 * 1024 * 1024;

  Stream<List<Document>> watchAll() => (_db.select(_db.documents)
        ..where((d) => d.deletedAt.isNull())
        ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
      .watch();

  Future<Document?> byId(String id) => (_db.select(_db.documents)..where((d) => d.id.equals(id))).getSingleOrNull();
  Stream<Document?> watchById(String id) => (_db.select(_db.documents)..where((d) => d.id.equals(id))).watchSingleOrNull();

  Future<List<DocumentExtraction>> extractions(String documentId) =>
      (_db.select(_db.documentExtractions)..where((e) => e.documentId.equals(documentId))).get();

  Stream<List<DocumentExtraction>> watchExtractions(String documentId) =>
      (_db.select(_db.documentExtractions)..where((e) => e.documentId.equals(documentId))).watch();

  Future<List<String>> pages(String documentId) async => [
        for (final c in await (_db.select(_db.documentChunks)
              ..where((c) => c.documentId.equals(documentId))
              ..orderBy([(c) => OrderingTerm.asc(c.ordinal)]))
            .get())
          c.body,
      ];

  Future<Uint8List> fileBytes(Document d) => _blobs.read(d.blobPath);

  /// Stores, reads and classifies a file, and proposes fields for review.
  Future<ImportResult> import({required String fileName, required String mimeType, required Uint8List bytes}) async {
    if (!supportedMimeTypes.contains(mimeType)) throw ArgumentError('Unsupported file type');
    if (bytes.length > maxBytes) throw ArgumentError('File too large');

    final digest = sha256.convert(bytes).toString();
    final existing = await (_db.select(_db.documents)..where((d) => d.sha256.equals(digest) & d.deletedAt.isNull()))
        .getSingleOrNull();
    if (existing != null) return ImportResult(existing.id, duplicate: true);

    final blob = await _blobs.write(bytes);
    // Text reading happens before any row exists, so a failure leaves no half-imported document.
    List<String> pageTexts;
    var ocrStatus = 'done';
    try {
      pageTexts = await _text.extract(bytes, mimeType);
    } on Object {
      pageTexts = const [];
      ocrStatus = 'failed';
    }
    final fullText = pageTexts.join('\n');
    final classification = classifyDocument(fullText, fileName: fileName);
    final fields = _extractor.extract(pageTexts);

    final id = _newId();
    final now = _now();
    try {
      await _writeImport(id, now, fileName, mimeType, digest, bytes.length, blob, ocrStatus, classification, pageTexts, fields);
    } on Object {
      // Never leave an encrypted file behind without its row.
      await _blobs.delete(blob);
      rethrow;
    }
    return ImportResult(id, duplicate: false);
  }

  Future<void> _writeImport(
    String id,
    DateTime now,
    String fileName,
    String mimeType,
    String digest,
    int size,
    String blob,
    String ocrStatus,
    Classification classification,
    List<String> pageTexts,
    List<ExtractedField> fields,
  ) {
    return _db.transaction(() async {
      await _db.into(_db.documents).insert(DocumentsCompanion.insert(
            id: id,
            source: Source.userStated,
            createdAt: now,
            updatedAt: now,
            fileName: fileName,
            mimeType: mimeType,
            sha256: digest,
            sizeBytes: size,
            blobPath: blob,
            docType: Value(classification.type),
            classificationConfidence: Value(classification.confidence),
            ocrStatus: Value(ocrStatus),
            extractionStatus: const Value('needs_review'),
            sensitivity: Value(_sensitivityFor(classification.type)),
          ));
      for (var i = 0; i < pageTexts.length; i++) {
        await _db.into(_db.documentChunks).insert(DocumentChunksCompanion.insert(
              id: _newId(),
              documentId: id,
              ordinal: i,
              body: pageTexts[i],
              page: Value(i + 1),
            ));
      }
      for (final f in fields) {
        await _insertField(id, f);
      }
      await _audit('document_added', id);
    });
  }

  /// Whether this document's text may be sent to the AI relay.
  static bool mayUseAi(Document d) => !localOnlyDocumentTypes.contains(d.docType);

  /// Adds AI-suggested fields after checking each one against the document.
  /// A suggestion is dropped unless its quote occurs in the text, its key is
  /// known, and a date value is a real date. Returns how many were kept.
  Future<int> addAiSuggestions(String documentId, {required String? title, required List<ExtractedField> suggestions}) {
    return _db.transaction(() async {
      final d = await byId(documentId);
      if (d == null) throw StateError('Unknown document');
      if (!mayUseAi(d)) throw StateError('Local-only document');
      final text = (await pages(documentId)).join('\n');
      final existing = {for (final e in await extractions(documentId)) e.field};
      var kept = 0;
      for (final s in suggestions) {
        final known = dateFieldKeys.contains(s.key) || textFieldKeys.contains(s.key);
        final validDate = !dateFieldKeys.contains(s.key) || _parseIsoDate(s.value) != null;
        if (!known || !validDate || !quoteOccursIn(s.quote, text) || existing.contains(s.key)) continue;
        await _insertField(documentId, s);
        existing.add(s.key);
        kept++;
      }
      if (title != null && title.trim().isNotEmpty && d.title == null) {
        await (_db.update(_db.documents)..where((x) => x.id.equals(documentId)))
            .write(DocumentsCompanion(title: Value(title.trim()), updatedAt: Value(_now())));
      }
      await _db.audit(
        actor: 'agent',
        action: 'document_ai_fields',
        outcome: 'kept_${kept}_of_${suggestions.length}',
        targetType: 'document',
        targetId: documentId,
        at: _now(),
      );
      return kept;
    });
  }

  Future<void> setFieldStatus(String extractionId, ReviewStatus status, {String? value}) =>
      (_db.update(_db.documentExtractions)..where((e) => e.id.equals(extractionId))).write(DocumentExtractionsCompanion(
        reviewStatus: Value(value == null ? status : ReviewStatus.edited),
        value: value == null ? const Value.absent() : Value(value),
      ));

  Future<void> setType(String documentId, String docType) async {
    if (!documentTypes.contains(docType)) throw ArgumentError('Unknown type');
    await (_db.update(_db.documents)..where((d) => d.id.equals(documentId))).write(DocumentsCompanion(
      docType: Value(docType),
      classificationConfidence: const Value(1.0),
      sensitivity: Value(_sensitivityFor(docType)),
      updatedAt: Value(_now()),
    ));
  }

  /// Turns the accepted fields into an entity with dates and, for an expiry or
  /// renewal date in the future, a reminder [leadDays] before it.
  Future<List<ConfirmedDate>> confirmReview(String documentId, {required String reminderTitle, int? leadDays}) {
    return _db.transaction(() async {
      final d = await byId(documentId);
      if (d == null) throw StateError('Unknown document');
      final accepted = (await extractions(documentId))
          .where((e) => e.reviewStatus == ReviewStatus.accepted || e.reviewStatus == ReviewStatus.edited)
          .toList();
      final now = _now();

      var entityId = d.entityId;
      if (entityId == null) {
        entityId = _newId();
        await _db.into(_db.entities).insert(EntitiesCompanion.insert(
              id: entityId,
              source: Source.document,
              sourceRef: Value(documentId),
              createdAt: now,
              updatedAt: now,
              type: d.docType ?? 'other',
              displayName: d.title ?? d.fileName,
              sensitivity: Value(d.sensitivity),
              attributes: Value(_attributesJson(accepted)),
            ));
      }

      final confirmed = <ConfirmedDate>[];
      final lead = leadDays ?? reminderLeadDays[d.docType] ?? 14;
      for (final e in accepted.where((e) => dateFieldKeys.contains(e.field))) {
        final date = _parseIsoDate(e.value);
        if (date == null) continue;
        await _db.into(_db.entityDates).insert(EntityDatesCompanion.insert(
              id: _newId(),
              source: Source.document,
              sourceRef: Value(documentId),
              createdAt: now,
              updatedAt: now,
              entityId: entityId,
              kind: e.field.replaceAll('_on', ''),
              date: date,
            ));
        DateTime? reminderAt;
        if (e.field == 'expires_on' || e.field == 'renews_on' || e.field == 'due_on') {
          // Payments get a short lead; expiries and renewals the per-type lead.
          final days = e.field == 'due_on' ? 3 : lead;
          final at = DateTime(date.year, date.month, date.day - days, 9);
          if (at.isAfter(now)) {
            await _planner.createReminder(title: reminderTitle, fireAt: at, targetId: documentId);
            reminderAt = at;
          }
        }
        confirmed.add(ConfirmedDate(kind: e.field, date: date, reminderAt: reminderAt));
      }

      await (_db.update(_db.documents)..where((x) => x.id.equals(documentId))).write(DocumentsCompanion(
        entityId: Value(entityId),
        extractionStatus: const Value('reviewed'),
        updatedAt: Value(now),
      ));
      await _audit('document_reviewed', documentId);
      return confirmed;
    });
  }

  /// Removes the file, its text, fields, dates, entity and reminders.
  Future<void> delete(String documentId) async {
    final d = await byId(documentId);
    if (d == null) return;
    await _planner.deleteRemindersFor(documentId);
    await _db.transaction(() async {
      await (_db.delete(_db.documentChunks)..where((c) => c.documentId.equals(documentId))).go();
      await (_db.delete(_db.documentExtractions)..where((e) => e.documentId.equals(documentId))).go();
      await (_db.delete(_db.documents)..where((x) => x.id.equals(documentId))).go();
      if (d.entityId != null) {
        await (_db.delete(_db.entityDates)..where((x) => x.entityId.equals(d.entityId!))).go();
        await (_db.delete(_db.entities)..where((x) => x.id.equals(d.entityId!))).go();
      }
      await _audit('document_deleted', documentId);
    });
    await _blobs.delete(d.blobPath);
  }

  /// Every term must appear in the name, type, text or extracted values.
  Future<List<Document>> search(String query, {String? docType, int limit = 20}) async {
    final terms = searchTerms(query);
    final docs = await (_db.select(_db.documents)
          ..where((d) => d.deletedAt.isNull())
          ..where((d) => docType == null ? const Constant(true) : d.docType.equals(docType))
          ..orderBy([(d) => OrderingTerm.desc(d.createdAt)]))
        .get();
    if (terms.isEmpty) return docs.take(limit).toList();
    final out = <Document>[];
    for (final d in docs) {
      final text = [
        d.fileName,
        d.title ?? '',
        d.docType ?? '',
        ...await pages(d.id),
        for (final e in await extractions(d.id)) e.value,
      ].join(' ');
      if (terms.every(foldForSearch(text).contains)) out.add(d);
      if (out.length >= limit) break;
    }
    return out;
  }

  Future<void> _insertField(String documentId, ExtractedField f) =>
      _db.into(_db.documentExtractions).insert(DocumentExtractionsCompanion.insert(
            id: _newId(),
            documentId: documentId,
            field: f.key,
            value: f.value,
            confidence: f.confidence,
            page: Value(f.page),
            quote: Value(f.quote),
            origin: Value(f.origin),
          ));

  static Sensitivity _sensitivityFor(String type) => switch (type) {
        'medical' => Sensitivity.specialCategory,
        'passport' || 'id_card' || 'driver_license' => Sensitivity.sensitive,
        'invoice' || 'receipt' || 'contract' || 'insurance' => Sensitivity.personal,
        _ => Sensitivity.normal,
      };

  static DateTime? _parseIsoDate(String v) {
    final m = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch(v.trim());
    if (m == null) return null;
    final y = int.parse(m[1]!), mo = int.parse(m[2]!), d = int.parse(m[3]!);
    final date = DateTime(y, mo, d);
    return date.year == y && date.month == mo && date.day == d ? date : null;
  }

  static String _attributesJson(List<DocumentExtraction> accepted) =>
      jsonEncode({for (final e in accepted.where((e) => textFieldKeys.contains(e.field))) e.field: e.value});

  Future<void> _audit(String action, String id) =>
      _db.audit(actor: 'user', action: action, outcome: 'ok', targetType: 'document', targetId: id, at: _now());
}
