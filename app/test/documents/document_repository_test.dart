import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/documents/blob_store.dart';
import 'package:life_os/core/documents/document_repository.dart';
import 'package:life_os/core/documents/document_tools.dart';
import 'package:life_os/core/documents/field_extractor.dart';
import 'package:life_os/core/documents/text_extractor.dart';
import 'package:life_os/core/planner/planner_repository.dart';

import '../planner/planner_repository_test.dart' show FakeNotifications;
import 'document_core_test.dart' show kaskoTr, passportEn;

/// Returns canned page text instead of running PDFium/ML Kit.
class FakeTextExtractor implements TextExtractor {
  FakeTextExtractor(this.pagesByContent);
  final Map<String, List<String>> pagesByContent;
  bool fail = false;

  @override
  Future<List<String>> extract(Uint8List bytes, String mimeType) async {
    if (fail) throw StateError('OCR failed');
    return pagesByContent[utf8.decode(bytes)] ?? const [];
  }
}

void main() {
  late LifeDatabase db;
  late Directory dir;
  late FakeNotifications notifications;
  late DocumentRepository repo;
  late FakeTextExtractor text;
  final now = DateTime(2026, 9, 23, 10);

  setUp(() async {
    db = LifeDatabase(NativeDatabase.memory());
    dir = await Directory.systemTemp.createTemp('docs');
    notifications = FakeNotifications();
    text = FakeTextExtractor({'kasko-file': [kaskoTr], 'passport-file': [passportEn]});
    final planner = PlannerRepository(db, notifications, clock: () => now);
    repo = DocumentRepository(
      db,
      EncryptedBlobStore(dir, () async => 'ab' * 32),
      text,
      planner,
      clock: () => now,
    );
  });
  tearDown(() async {
    await db.close();
    await dir.delete(recursive: true);
  });

  Future<String> importKasko() async =>
      (await repo.import(fileName: 'kasko.pdf', mimeType: 'application/pdf', bytes: Uint8List.fromList(utf8.encode('kasko-file')))).id;

  Future<void> acceptAll(String id) async {
    for (final e in await repo.extractions(id)) {
      await repo.setFieldStatus(e.id, ReviewStatus.accepted);
    }
  }

  test('import stores an encrypted file, text, type and proposed fields — nothing confirmed yet', () async {
    final id = await importKasko();
    final d = (await repo.byId(id))!;
    expect(d.docType, 'insurance');
    expect(d.extractionStatus, 'needs_review');
    expect(await repo.pages(id), [kaskoTr]);
    expect((await repo.extractions(id)).map((e) => e.field), containsAll(['expires_on', 'policy_number']));
    expect((await repo.extractions(id)).every((e) => e.reviewStatus == ReviewStatus.pending), isTrue);
    expect(await db.select(db.entityDates).get(), isEmpty);
    expect(notifications.scheduled, isEmpty, reason: 'no reminder before the user confirms');
    expect(utf8.decode(await repo.fileBytes(d)), 'kasko-file');
  });

  test('the same file twice is recognised as a duplicate', () async {
    final a = await importKasko();
    final b = await repo.import(fileName: 'copy.pdf', mimeType: 'application/pdf', bytes: Uint8List.fromList(utf8.encode('kasko-file')));
    expect(b.duplicate, isTrue);
    expect(b.id, a);
    expect(await db.select(db.documents).get(), hasLength(1));
  });

  test('unsupported or oversized files are refused', () async {
    expect(() => repo.import(fileName: 'x.exe', mimeType: 'application/octet-stream', bytes: Uint8List(1)), throwsArgumentError);
    expect(
      () => repo.import(fileName: 'big.pdf', mimeType: 'application/pdf', bytes: Uint8List(DocumentRepository.maxBytes + 1)),
      throwsArgumentError,
    );
  });

  test('if text reading fails the document is still kept, marked for manual review', () async {
    text.fail = true;
    final id = await importKasko();
    final d = (await repo.byId(id))!;
    expect(d.ocrStatus, 'failed');
    expect(await repo.extractions(id), isEmpty);
  });

  test('confirming creates an entity, dates and a reminder 30 days before expiry', () async {
    final id = await importKasko();
    await acceptAll(id);
    final confirmed = await repo.confirmReview(id, reminderTitle: 'Kasko renewal');

    final expiry = confirmed.firstWhere((c) => c.kind == 'expires_on');
    expect(expiry.date, DateTime(2027, 5, 10));
    expect(expiry.reminderAt, DateTime(2027, 4, 10, 9));
    expect(notifications.scheduled.values.single.at, DateTime(2027, 4, 10, 9));

    final entity = await db.select(db.entities).getSingle();
    expect(entity.type, 'insurance');
    expect(jsonDecode(entity.attributes)['policy_number'], '1234567-89');
    final dates = await db.select(db.entityDates).get();
    expect(dates.map((d) => d.kind), containsAll(['expires', 'starts', 'issued']));
    expect((await repo.byId(id))!.extractionStatus, 'reviewed');
  });

  test('rejected fields are not used, and edited values are', () async {
    final id = await importKasko();
    for (final e in await repo.extractions(id)) {
      if (e.field == 'expires_on') {
        await repo.setFieldStatus(e.id, ReviewStatus.accepted, value: '2027-06-01');
      } else {
        await repo.setFieldStatus(e.id, ReviewStatus.rejected);
      }
    }
    final confirmed = await repo.confirmReview(id, reminderTitle: 'r');
    expect(confirmed.single.date, DateTime(2027, 6, 1));
    expect(jsonDecode((await db.select(db.entities).getSingle()).attributes), isEmpty);
  });

  test('an expiry already in the past gets no reminder', () async {
    text.pagesByContent['old'] = ['KASKO POLİÇESİ Bitiş Tarihi: 01.01.2026'];
    final id = (await repo.import(fileName: 'old.pdf', mimeType: 'application/pdf', bytes: Uint8List.fromList(utf8.encode('old')))).id;
    await acceptAll(id);
    final confirmed = await repo.confirmReview(id, reminderTitle: 'r');
    expect(confirmed.single.reminderAt, isNull);
    expect(notifications.scheduled, isEmpty);
  });

  group('AI suggestions', () {
    test('only suggestions quoting the document are kept', () async {
      text.pagesByContent['bare'] = ['ANADOLU SİGORTA KASKO POLİÇESİ\nSigorta Şirketi: Anadolu Sigorta A.Ş.\nYenileme Tarihi: 10.05.2027'];
      final id = (await repo.import(fileName: 'b.pdf', mimeType: 'application/pdf', bytes: Uint8List.fromList(utf8.encode('bare')))).id;
      final before = (await repo.extractions(id)).length;
      final kept = await repo.addAiSuggestions(id, title: 'Kasko – Anadolu Sigorta', suggestions: const [
        ExtractedField(key: 'provider', value: 'Anadolu Sigorta', quote: 'Sigorta Şirketi: Anadolu Sigorta A.Ş.', confidence: 0.9, origin: 'ai'),
        ExtractedField(key: 'expires_on', value: '2027-05-10', quote: 'Bitiş Tarihi: 10.05.2027', confidence: 0.9, origin: 'ai'),
        ExtractedField(key: 'vehicle_model', value: 'Seal U', quote: 'Model: Seal U', confidence: 0.9, origin: 'ai'),
        ExtractedField(key: 'owner_tc_no', value: '12345678901', quote: 'ANADOLU SİGORTA', confidence: 0.9, origin: 'ai'),
      ]);
      expect(kept, 1, reason: 'invented quotes and unknown keys are dropped');
      final fields = await repo.extractions(id);
      expect(fields.length, before + 1);
      expect(fields.firstWhere((f) => f.field == 'provider').origin, 'ai');
      expect((await repo.byId(id))!.title, 'Kasko – Anadolu Sigorta');
      expect((await db.select(db.auditLogs).get()).last.outcome, 'kept_1_of_4');
    });

    test('AI suggestions never replace a field the device already read', () async {
      final id = await importKasko();
      final kept = await repo.addAiSuggestions(id, title: null, suggestions: const [
        ExtractedField(key: 'expires_on', value: '2027-05-10', quote: 'Bitiş Tarihi: 10.05.2027', confidence: 1, origin: 'ai'),
      ]);
      expect(kept, 0);
    });

    test('identity documents cannot receive AI suggestions', () async {
      final id = (await repo.import(fileName: 'p.jpg', mimeType: 'image/jpeg', bytes: Uint8List.fromList(utf8.encode('passport-file')))).id;
      final d = (await repo.byId(id))!;
      expect(d.docType, 'passport');
      expect(d.sensitivity, Sensitivity.sensitive);
      expect(DocumentRepository.mayUseAi(d), isFalse);
      expect(() => repo.addAiSuggestions(id, title: null, suggestions: const []), throwsStateError);
    });
  });

  test('delete removes the file, text, fields, entity, dates and reminders', () async {
    final id = await importKasko();
    await acceptAll(id);
    await repo.confirmReview(id, reminderTitle: 'r');
    final blob = (await repo.byId(id))!.blobPath;

    await repo.delete(id);
    expect(await db.select(db.documents).get(), isEmpty);
    expect(await db.select(db.documentChunks).get(), isEmpty);
    expect(await db.select(db.documentExtractions).get(), isEmpty);
    expect(await db.select(db.entities).get(), isEmpty);
    expect(await db.select(db.entityDates).get(), isEmpty);
    expect(await db.select(db.reminders).get(), isEmpty);
    expect(notifications.scheduled, isEmpty);
    expect(File('${dir.path}/$blob').existsSync(), isFalse);
  });

  test('search reads text and fields, Turkish-aware', () async {
    await importKasko();
    await repo.import(fileName: 'p.jpg', mimeType: 'image/jpeg', bytes: Uint8List.fromList(utf8.encode('passport-file')));
    expect((await repo.search('POLİÇE 34 abc')).single.fileName, 'kasko.pdf');
    expect((await repo.search('passport')).single.fileName, 'p.jpg');
    expect(await repo.search('tapu'), isEmpty);
  });

  test('search_documents shares fields of ordinary documents only', () async {
    final id = await importKasko();
    await acceptAll(id);
    await repo.import(fileName: 'p.jpg', mimeType: 'image/jpeg', bytes: Uint8List.fromList(utf8.encode('passport-file')));
    final tools = DocumentTools(repo);

    final kasko = (jsonDecode(await tools.searchDocuments({'query': 'kasko'})) as List).single as Map;
    expect(kasko['fields']['expires_on'], '2027-05-10');

    final passport = (jsonDecode(await tools.searchDocuments({'query': 'passport'})) as List).single as Map;
    expect(passport.containsKey('fields'), isFalse);
    expect(jsonEncode(passport), isNot(contains('2032')), reason: 'no passport contents reach the model');
  });
}
