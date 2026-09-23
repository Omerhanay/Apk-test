import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';
import 'package:path/path.dart' as p;

/// Where document files are kept. The app always uses [EncryptedBlobStore].
abstract interface class BlobStore {
  Future<String> write(Uint8List plain);
  Future<Uint8List> read(String name);
  Future<void> delete(String name);
}

/// Stores document files encrypted with AES-256-GCM.
///
/// File layout: "LOS1" | 12-byte nonce | ciphertext | 16-byte tag. Each file
/// gets a fresh random nonce; the tag makes tampering detectable.
class EncryptedBlobStore implements BlobStore {
  EncryptedBlobStore(this._dir, this._keyHex);

  final Directory _dir;
  final Future<String> Function() _keyHex;
  static final _cipher = AesGcm.with256bits();
  static const _magic = [0x4c, 0x4f, 0x53, 0x31]; // "LOS1"

  Future<SecretKey> _key() async {
    final hex = await _keyHex();
    return SecretKey([for (var i = 0; i < hex.length; i += 2) int.parse(hex.substring(i, i + 2), radix: 16)]);
  }

  /// Encrypts [plain] into a new file and returns its path relative to the store.
  @override
  Future<String> write(Uint8List plain) async {
    await _dir.create(recursive: true);
    final rng = Random.secure();
    final name = '${List.generate(16, (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0')).join()}.bin';
    final box = await _cipher.encrypt(plain, secretKey: await _key(), nonce: _cipher.newNonce());
    final out = BytesBuilder(copy: false)
      ..add(_magic)
      ..add(box.nonce)
      ..add(box.cipherText)
      ..add(box.mac.bytes);
    await File(p.join(_dir.path, name)).writeAsBytes(out.takeBytes(), flush: true);
    return name;
  }

  /// Decrypts a stored file. Throws [SecretBoxAuthenticationError] if it was altered.
  @override
  Future<Uint8List> read(String name) async {
    final data = await File(p.join(_dir.path, p.basename(name))).readAsBytes();
    if (data.length < 4 + 12 + 16 || !Iterable.generate(4).every((i) => data[i] == _magic[i])) {
      throw const FormatException('Not a LIFE OS encrypted file');
    }
    final box = SecretBox(
      data.sublist(16, data.length - 16),
      nonce: data.sublist(4, 16),
      mac: Mac(data.sublist(data.length - 16)),
    );
    return Uint8List.fromList(await _cipher.decrypt(box, secretKey: await _key()));
  }

  @override
  Future<void> delete(String name) async {
    final f = File(p.join(_dir.path, p.basename(name)));
    if (await f.exists()) await f.delete();
  }
}
