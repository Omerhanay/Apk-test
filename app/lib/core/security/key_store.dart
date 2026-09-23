import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Minimal secret storage interface so tests can run without the Android Keystore.
abstract interface class SecretStore {
  Future<String?> read(String key);
  Future<void> write(String key, String value);
  Future<void> delete(String key);
}

/// Android Keystore-backed encrypted storage.
class SecureStorageSecretStore implements SecretStore {
  const SecureStorageSecretStore([this._storage = const FlutterSecureStorage()]);
  final FlutterSecureStorage _storage;

  @override
  Future<String?> read(String key) => _storage.read(key: key);
  @override
  Future<void> write(String key, String value) => _storage.write(key: key, value: value);
  @override
  Future<void> delete(String key) => _storage.delete(key: key);
}

/// Holds device-local secrets: the database key and relay credentials.
class KeyStore {
  KeyStore(this._storage);

  final SecretStore _storage;

  static const _dbKey = 'db_key_v1';
  static const _fileKey = 'file_key_v1';
  static const _relayToken = 'relay_token_v1';
  static const _relayUrl = 'relay_url_v1';

  /// The relay rejects shorter tokens; see relay/src/auth.ts.
  static const minTokenLength = 32;

  /// 256-bit database key as hex, created on first use.
  Future<String> databaseKey() => _randomKey(_dbKey);

  /// 256-bit key for encrypted document files, separate from the database key.
  Future<String> fileKey() => _randomKey(_fileKey);

  Future<String> _randomKey(String name) async {
    final existing = await _storage.read(name);
    if (existing != null) return existing;
    final rng = Random.secure();
    final key = List.generate(32, (_) => rng.nextInt(256).toRadixString(16).padLeft(2, '0')).join();
    await _storage.write(name, key);
    return key;
  }

  Future<RelayCredentials?> relayCredentials() async {
    final url = await _storage.read(_relayUrl);
    final token = await _storage.read(_relayToken);
    if (url == null || token == null) return null;
    return RelayCredentials(Uri.parse(url), token);
  }

  Future<void> saveRelayCredentials(RelayCredentials c) async {
    final problem = RelayCredentials.validate(c.baseUrl.toString(), c.token);
    if (problem != null) throw ArgumentError(problem.name);
    await _storage.write(_relayUrl, c.baseUrl.toString());
    await _storage.write(_relayToken, c.token);
  }

  Future<void> clearRelayCredentials() async {
    await _storage.delete(_relayUrl);
    await _storage.delete(_relayToken);
  }
}

enum RelayCredentialProblem { notHttps, tokenTooShort }

class RelayCredentials {
  const RelayCredentials(this.baseUrl, this.token);
  final Uri baseUrl;
  final String token;

  /// Only https relays are accepted: the token and your questions travel to it.
  static RelayCredentialProblem? validate(String url, String token) {
    final uri = Uri.tryParse(url.trim());
    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) return RelayCredentialProblem.notHttps;
    if (token.trim().length < KeyStore.minTokenLength) return RelayCredentialProblem.tokenTooShort;
    return null;
  }
}
