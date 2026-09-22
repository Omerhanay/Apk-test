import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/agent/schema_validator.dart';
import 'package:life_os/core/agent/tool_contract.dart';

void main() {
  test('bundled contract matches the repository contract', () {
    final bundled = File('assets/contracts/agent-tools.json').readAsStringSync();
    final source = File('../contracts/agent-tools.json').readAsStringSync();
    expect(bundled, source, reason: 'Run: cp ../contracts/agent-tools.json assets/contracts/');
  });

  test('every tool schema uses only validator-supported keywords', () {
    final registry = ToolRegistry.fromContractJson(File('assets/contracts/agent-tools.json').readAsStringSync());
    for (final tool in registry.all) {
      // An empty object passes or fails on `required` only, never on an unsupported keyword.
      final errors = validateAgainstSchema(<String, dynamic>{}, tool.inputSchema);
      expect(errors.where((e) => e.contains('unsupported')), isEmpty, reason: tool.name);
    }
  });

  test('read tools carry no risk and commit tools carry some', () {
    final registry = ToolRegistry.fromContractJson(File('assets/contracts/agent-tools.json').readAsStringSync());
    for (final tool in registry.all) {
      if (tool.effect == ToolEffect.read) {
        expect(tool.risk, RiskTier.none, reason: tool.name);
      } else {
        expect(tool.risk, isNot(RiskTier.none), reason: tool.name);
      }
    }
  });

  test('validator fails closed on unknown keywords', () {
    expect(validateAgainstSchema('x', {'type': 'string', 'pattern': '.*'}), isNotEmpty);
  });
}
