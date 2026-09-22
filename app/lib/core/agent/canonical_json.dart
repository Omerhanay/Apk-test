import 'dart:convert';

import 'package:crypto/crypto.dart';

/// JSON with object keys sorted recursively, so equal arguments always hash equally.
String canonicalJson(Object? value) {
  Object? normalize(Object? v) {
    if (v is Map) {
      final keys = v.keys.map((k) => k.toString()).toList()..sort();
      return {for (final k in keys) k: normalize(v[k])};
    }
    if (v is List) return v.map(normalize).toList();
    return v;
  }

  return jsonEncode(normalize(value));
}

/// Hash that binds an approval to the exact arguments the user previewed.
String argsHash(String tool, Map<String, dynamic> args) =>
    sha256.convert(utf8.encode(canonicalJson({'tool': tool, 'args': args}))).toString();
