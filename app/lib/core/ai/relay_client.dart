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

/// Structured reading of something the user said, from the relay's parser.
class MemoryParseResult {
  const MemoryParseResult({
    required this.op,
    required this.content,
    required this.category,
    required this.kind,
    this.subject,
    this.predicate,
    this.value,
    this.validUntil,
    required this.sensitivity,
    required this.confidence,
    this.needsClarification,
  });

  factory MemoryParseResult.fromJson(Map<String, dynamic> j) => MemoryParseResult(
        op: j['op'] as String,
        content: j['content'] as String,
        category: j['category'] as String,
        kind: j['kind'] as String,
        subject: j['subject'] as String?,
        predicate: j['predicate'] as String?,
        value: j['value'] as String?,
        validUntil: DateTime.tryParse(j['valid_until'] as String? ?? ''),
        sensitivity: j['sensitivity'] as String,
        confidence: (j['confidence'] as num).toDouble(),
        needsClarification: j['needs_clarification'] as String?,
      );

  final String op; // create | retract
  final String content;
  final String category;
  final String kind;
  final String? subject;
  final String? predicate;
  final String? value;
  final DateTime? validUntil;
  final String sensitivity;
  final double confidence;
  final String? needsClarification;
}

/// One field the AI read from a document, with the passage it came from.
class AiDocumentField {
  const AiDocumentField({required this.key, required this.value, required this.quote, required this.confidence});
  final String key;
  final String value;
  final String quote;
  final double confidence;
}

class AiDocumentExtraction {
  const AiDocumentExtraction({required this.docType, required this.title, required this.fields});
  final String docType;
  final String title;
  final List<AiDocumentField> fields;
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
    final body = jsonDecode(_utf8(res)) as Map<String, dynamic>;
    return RelayInfo(provider: body['provider'] as String, promptVersion: body['prompt_version'] as String);
  }

  /// Sends one statement to be structured. Only the text, the date, the
  /// language and the keys (not contents) of existing facts are sent.
  Future<MemoryParseResult> parseMemory({
    required String text,
    required String locale,
    required DateTime today,
    required List<({String subject, String predicate})> knownSubjects,
  }) async {
    final day = '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final res = await _send(() => _http
        .post(
          _credentials.baseUrl.resolve('/v1/memory/parse'),
          headers: _headers,
          body: jsonEncode({
            'text': text,
            'locale': locale,
            'today': day,
            'known_subjects': [for (final k in knownSubjects) {'subject': k.subject, 'predicate': k.predicate}],
          }),
        )
        .timeout(const Duration(seconds: 45)));
    return MemoryParseResult.fromJson(jsonDecode(_utf8(res)) as Map<String, dynamic>);
  }

  /// Sends a document's OCR text (never the file) for field extraction.
  Future<AiDocumentExtraction> extractDocument({
    required String text,
    required String docType,
    required String locale,
    required DateTime today,
  }) async {
    final day = '${today.year.toString().padLeft(4, '0')}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';
    final res = await _send(() => _http
        .post(
          _credentials.baseUrl.resolve('/v1/document/extract'),
          headers: _headers,
          body: jsonEncode({'text': text, 'doc_type': docType, 'locale': locale, 'today': day}),
        )
        .timeout(const Duration(seconds: 90)));
    final j = jsonDecode(_utf8(res)) as Map<String, dynamic>;
    return AiDocumentExtraction(
      docType: j['doc_type'] as String,
      title: j['title'] as String? ?? '',
      fields: [
        for (final f in (j['fields'] as List).cast<Map<String, dynamic>>())
          AiDocumentField(
            key: f['key'] as String,
            value: f['value'] as String,
            quote: f['quote'] as String,
            confidence: (f['confidence'] as num).toDouble(),
          ),
      ],
    );
  }

  Future<AgentTurn> agentTurn(List<WireMessage> messages) async {
    final res = await _send(() => _http
        .post(
          _credentials.baseUrl.resolve('/v1/agent/turn'),
          headers: _headers,
          body: jsonEncode({'messages': messages.map((m) => m.toJson()).toList()}),
        )
        .timeout(timeout));
    return AgentTurn.fromJson(jsonDecode(_utf8(res)) as Map<String, dynamic>);
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
      final body = jsonDecode(_utf8(res)) as Map<String, dynamic>;
      code = body['error'] as String? ?? code;
      retryable = body['retryable'] as bool? ?? retryable;
    } on FormatException {
      // Non-JSON error body; keep the status-derived code.
    }
    throw RelayException(code, retryable: retryable);
  }

  /// The relay always sends UTF-8 JSON. Decode the bytes directly: without a
  /// charset header, `http` would fall back to Latin-1 and garble Turkish text.
  static String _utf8(http.Response res) => utf8.decode(res.bodyBytes);
}
