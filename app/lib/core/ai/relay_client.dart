import 'dart:convert';

import 'package:http/http.dart' as http;

import '../security/key_store.dart';
import 'wire.dart';

class RelayException implements Exception {
  const RelayException(this.code, {this.retryable = false});

  /// Content-free code: unauthorized | rate_limited | upstream_unavailable | offline | ...
  final String code;
  final bool retryable;

  @override
  String toString() => 'RelayException($code)';
}

class RelayInfo {
  const RelayInfo({required this.provider, required this.promptVersion});
  final String provider;
  final String promptVersion;
}

/// Talks to the user's LIFE OS relay. The relay holds the LLM API key, so the
/// app never does.
class RelayClient {
  RelayClient(this._credentials, {http.Client? httpClient, this.timeout = const Duration(seconds: 90)})
      : _http = httpClient ?? http.Client();

  final RelayCredentials _credentials;
  final http.Client _http;
  final Duration timeout;

  Map<String, String> get _headers => {
        'authorization': 'Bearer ${_credentials.token}',
        'content-type': 'application/json',
      };

  /// Authenticated connectivity check used when pairing.
  Future<RelayInfo> ping() async {
    final res = await _send(() => _http
        .get(_credentials.baseUrl.resolve('/v1/ping'), headers: _headers)
        .timeout(const Duration(seconds: 15)));
    final body = jsonDecode(res.body) as Map<String, dynamic>;
    return RelayInfo(provider: body['provider'] as String, promptVersion: body['prompt_version'] as String);
  }

  Future<AgentTurn> agentTurn(List<WireMessage> messages) async {
    final res = await _send(() => _http
        .post(
          _credentials.baseUrl.resolve('/v1/agent/turn'),
          headers: _headers,
          body: jsonEncode({'messages': messages.map((m) => m.toJson()).toList()}),
        )
        .timeout(timeout));
    return AgentTurn.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  Future<http.Response> _send(Future<http.Response> Function() request) async {
    final http.Response res;
    try {
      res = await request();
    } on Exception {
      throw const RelayException('offline', retryable: true);
    }

    if (res.statusCode == 200) return res;
    if (res.statusCode == 401) throw const RelayException('unauthorized');

    var code = 'http_${res.statusCode}';
    var retryable = res.statusCode >= 500 || res.statusCode == 429;
    try {
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      code = body['error'] as String? ?? code;
      retryable = body['retryable'] as bool? ?? retryable;
    } on FormatException {
      // Non-JSON error body; keep the status-derived code.
    }
    throw RelayException(code, retryable: retryable);
  }
}
