/// Validates tool inputs against the JSON Schema subset used in the tool
/// contract: object/string/boolean/number/integer types, `required`,
/// `additionalProperties: false`, `enum`, string length and `date-time` format.
///
/// Model output is untrusted, so every tool call is validated here before the
/// firewall considers it. Unsupported schema keywords fail closed.
List<String> validateAgainstSchema(Object? value, Map<String, dynamic> schema, [String path = r'$']) {
  const supported = {
    'type', 'properties', 'required', 'additionalProperties', 'enum',
    'minLength', 'maxLength', 'format', 'description',
  };
  final unknown = schema.keys.where((k) => !supported.contains(k));
  if (unknown.isNotEmpty) return ['$path: unsupported schema keyword(s) ${unknown.join(', ')}'];

  final errors = <String>[];
  final type = schema['type'] as String?;

  switch (type) {
    case 'object':
      if (value is! Map) return ['$path: expected object'];
      final props = (schema['properties'] as Map?)?.cast<String, dynamic>() ?? const {};
      for (final req in (schema['required'] as List?)?.cast<String>() ?? const <String>[]) {
        if (!value.containsKey(req)) errors.add('$path.$req: required');
      }
      for (final entry in value.entries) {
        final key = entry.key;
        final propSchema = props[key];
        if (propSchema == null) {
          if (schema['additionalProperties'] == false) errors.add('$path.$key: not allowed');
          continue;
        }
        errors.addAll(validateAgainstSchema(entry.value, (propSchema as Map).cast<String, dynamic>(), '$path.$key'));
      }
    case 'string':
      if (value is! String) return ['$path: expected string'];
      final min = schema['minLength'] as int?;
      final max = schema['maxLength'] as int?;
      if (min != null && value.length < min) errors.add('$path: shorter than $min');
      if (max != null && value.length > max) errors.add('$path: longer than $max');
      if (schema['format'] == 'date-time' && DateTime.tryParse(value) == null) {
        errors.add('$path: not an ISO 8601 date-time');
      }
    case 'boolean':
      if (value is! bool) return ['$path: expected boolean'];
    case 'integer':
      if (value is! int) return ['$path: expected integer'];
    case 'number':
      if (value is! num) return ['$path: expected number'];
    case null:
      break;
    default:
      return ['$path: unsupported type $type'];
  }

  final allowed = schema['enum'] as List?;
  if (allowed != null && !allowed.contains(value)) errors.add('$path: not one of ${allowed.join(', ')}');
  return errors;
}
