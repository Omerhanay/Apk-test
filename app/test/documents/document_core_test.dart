import 'dart:io';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/documents/blob_store.dart';
import 'package:life_os/core/documents/classifier.dart';
import 'package:life_os/core/documents/field_extractor.dart';

const kaskoTr = '''
ANADOLU SİGORTA A.Ş.
KASKO SİGORTA POLİÇESİ
Poliçe No: 1234567-89
Sigortalı Araç Plaka: 34 ABC 123   Marka/Model: BYD Seal U
Başlangıç Tarihi: 10.05.2026   Bitiş Tarihi: 10.05.2027
Düzenleme Tarihi: 08.05.2026
''';

const passportEn = '''
REPUBLIC OF TÜRKİYE PASSPORT / PASAPORT
Date of issue 12 March 2022
Date of expiry 11 March 2032
P<TUR
''';

const invoiceTr = '''
ELEKTRİK FATURASI
Fatura No: ABC2026091
Fatura Tarihi: 01.09.2026
Son Ödeme Tarihi: 25.09.2026
Toplam: 812,40 TL (KDV dahil)
''';

void main() {
  group('EncryptedBlobStore', () {
    late Directory dir;
    late EncryptedBlobStore store;
    const key = '00112233445566778899aabbccddeeff00112233445566778899aabbccddeeff';

    setUp(() async {
      dir = await Directory.systemTemp.createTemp('blobs');
      store = EncryptedBlobStore(dir, () async => key);
    });
    tearDown(() => dir.delete(recursive: true));

    test('round-trips and stores no plaintext', () async {
      final plain = Uint8List.fromList('Poliçe No: 1234567-89 gizli'.codeUnits);
      final name = await store.write(plain);
      final onDisk = await File('${dir.path}/$name').readAsBytes();
      expect(String.fromCharCodes(onDisk).contains('1234567'), isFalse);
      expect(await store.read(name), plain);
    });

    test('same content encrypts differently each time', () async {
      final plain = Uint8List.fromList(List.filled(64, 7));
      final a = await File('${dir.path}/${await store.write(plain)}').readAsBytes();
      final b = await File('${dir.path}/${await store.write(plain)}').readAsBytes();
      expect(a, isNot(b));
    });

    test('tampering and wrong keys are detected', () async {
      final name = await store.write(Uint8List.fromList([1, 2, 3, 4, 5]));
      final f = File('${dir.path}/$name');
      final bytes = await f.readAsBytes();
      bytes[20] ^= 0xff;
      await f.writeAsBytes(bytes);
      await expectLater(store.read(name), throwsA(isA<SecretBoxAuthenticationError>()));

      final other = EncryptedBlobStore(dir, () async => 'ff' * 32);
      final name2 = await store.write(Uint8List.fromList([9, 9, 9]));
      await expectLater(other.read(name2), throwsA(isA<SecretBoxAuthenticationError>()));
    });

    test('reads only inside its directory', () async {
      final name = await store.write(Uint8List.fromList([1]));
      expect(await store.read('../../$name'), [1], reason: 'path components are stripped');
    });
  });

  group('classifyDocument', () {
    test('Turkish insurance, invoice; English passport', () {
      expect(classifyDocument(kaskoTr).type, 'insurance');
      expect(classifyDocument(invoiceTr).type, 'invoice');
      expect(classifyDocument(passportEn).type, 'passport');
    });

    test('word starts only: "ofis" is not a receipt', () {
      expect(classifyDocument('Ofis taşıma listesi, masalar ve sandalyeler').type, 'other');
    });

    test('identity and health documents are local-only', () {
      expect(localOnlyDocumentTypes, containsAll(['passport', 'id_card', 'driver_license', 'medical']));
      expect(classifyDocument('REÇETE\nHasta: ...\nİlaç: ...').type, 'medical');
    });
  });

  group('FieldExtractor', () {
    const x = FieldExtractor();
    Map<String, ExtractedField> fields(String text) => {for (final f in x.extract([text])) f.key: f};

    test('Turkish kasko policy', () {
      final f = fields(kaskoTr);
      expect(f['expires_on']!.value, '2027-05-10');
      expect(f['starts_on']!.value, '2026-05-10');
      expect(f['issued_on']!.value, '2026-05-08');
      expect(f['policy_number']!.value, '1234567-89');
      expect(f['vehicle_plate']!.value, '34 ABC 123');
      expect(f['expires_on']!.quote, 'Bitiş Tarihi: 10.05.2027', reason: 'quote comes from the original text');
    });

    test('English month names on a passport', () {
      final f = fields(passportEn);
      expect(f['expires_on']!.value, '2032-03-11');
      expect(f['issued_on']!.value, '2022-03-12');
    });

    test('invoice due date and number', () {
      final f = fields(invoiceTr);
      expect(f['due_on']!.value, '2026-09-25');
      expect(f['reference']!.value, 'ABC2026091');
    });

    test('an unlabelled date is not guessed to be anything', () {
      expect(x.extract(['Toplantı notları 14.10.2026 tarihinde yazıldı']), isEmpty);
    });

    test('impossible dates are ignored', () {
      expect(x.extract(['Bitiş Tarihi: 31.02.2027']), isEmpty);
    });
  });

  group('quoteOccursIn', () {
    test('accepts real quotes regardless of case, diacritics and spacing', () {
      expect(quoteOccursIn('bitis tarihi:  10.05.2027', kaskoTr), isTrue);
      expect(quoteOccursIn('POLİÇE NO: 1234567-89', kaskoTr), isTrue);
    });

    test('rejects invented or trivial quotes', () {
      expect(quoteOccursIn('Bitiş Tarihi: 10.05.2028', kaskoTr), isFalse);
      expect(quoteOccursIn('A.Ş', kaskoTr), isFalse, reason: 'too short to prove anything');
    });
  });
}
