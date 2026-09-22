import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/agent/firewall.dart';
import 'package:life_os/core/agent/tool_contract.dart';

void main() {
  final registry = ToolRegistry.fromContractJson(File('assets/contracts/agent-tools.json').readAsStringSync());
  final now = DateTime.utc(2026, 9, 22, 10);
  final firewall = PermissionFirewall(registry, clock: () => now);

  // A registry containing a high-risk tool, which the MVP contract does not yet expose.
  final withPayment = ToolRegistry([
    ...registry.all,
    const ToolDef(
      name: 'make_payment',
      description: 'test',
      capability: 'MAKE_PAYMENT',
      effect: ToolEffect.commit,
      risk: RiskTier.high,
      inputSchema: {'type': 'object', 'properties': {'amount': {'type': 'number'}}, 'required': ['amount'], 'additionalProperties': false},
    ),
  ]);

  Map<String, PermissionGrant> grants(List<PermissionGrant> list) => {for (final g in list) g.capability: g};

  const task = {'title': 'Renew insurance'};

  group('ACTION BLOCKED', () {
    test('unknown tool', () {
      final d = firewall.evaluate(toolName: 'send_email', input: const {}, grants: const {});
      expect(d.verdict, Verdict.block);
      expect(d.reason, DecisionReason.unknownTool);
    });

    test('no grant for the capability', () {
      final d = firewall.evaluate(toolName: 'create_task', input: task, grants: const {});
      expect(d.verdict, Verdict.block);
      expect(d.reason, DecisionReason.permissionMissing);
    });

    test('grant explicitly denied', () {
      final d = firewall.evaluate(
        toolName: 'create_task',
        input: task,
        grants: grants([const PermissionGrant(capability: 'CREATE_TASK', granted: false, autonomous: true)]),
      );
      expect(d.verdict, Verdict.block);
    });

    test('grant expired', () {
      final d = firewall.evaluate(
        toolName: 'create_task',
        input: task,
        grants: grants([PermissionGrant(capability: 'CREATE_TASK', granted: true, autonomous: true, expiresAt: now)]),
      );
      expect(d.verdict, Verdict.block);
      expect(d.reason, DecisionReason.permissionExpired);
    });

    test('read tools are blocked too without a grant', () {
      final d = firewall.evaluate(toolName: 'search_memory', input: const {'query': 'car'}, grants: const {});
      expect(d.verdict, Verdict.block);
    });

    test('invalid or smuggled arguments', () {
      final g = grants([const PermissionGrant(capability: 'CREATE_TASK', granted: true, autonomous: true)]);
      for (final input in <Map<String, dynamic>>[
        {},
        {'title': ''},
        {'title': 'x', 'approved': true},
        {'title': 'x', 'due_at': 'tomorrow'},
        {'title': 'x', 'priority': 'urgent'},
      ]) {
        final d = firewall.evaluate(toolName: 'create_task', input: input, grants: g);
        expect(d.verdict, Verdict.block, reason: '$input');
        expect(d.reason, DecisionReason.invalidInput);
      }
    });
  });

  group('approval policy', () {
    test('reads run when granted', () {
      final d = firewall.evaluate(
        toolName: 'search_memory',
        input: const {'query': 'car'},
        grants: grants([const PermissionGrant(capability: 'READ_MEMORY', granted: true)]),
      );
      expect(d.verdict, Verdict.allow);
    });

    test('low-risk commit needs approval by default', () {
      final d = firewall.evaluate(
        toolName: 'create_task',
        input: task,
        grants: grants([const PermissionGrant(capability: 'CREATE_TASK', granted: true)]),
      );
      expect(d.verdict, Verdict.requireApproval);
      expect(d.reason, DecisionReason.approvalRequired);
    });

    test('low-risk commit runs automatically only with autonomy', () {
      final d = firewall.evaluate(
        toolName: 'create_task',
        input: task,
        grants: grants([const PermissionGrant(capability: 'CREATE_TASK', granted: true, autonomous: true)]),
      );
      expect(d.verdict, Verdict.allow);
    });

    test('untrusted context revokes autonomy', () {
      final d = firewall.evaluate(
        toolName: 'create_task',
        input: task,
        grants: grants([const PermissionGrant(capability: 'CREATE_TASK', granted: true, autonomous: true)]),
        contextTainted: true,
      );
      expect(d.verdict, Verdict.requireApproval);
      expect(d.reason, DecisionReason.untrustedContext);
    });

    test('high risk always needs approval with biometrics, even with autonomy', () {
      final d = PermissionFirewall(withPayment, clock: () => now).evaluate(
        toolName: 'make_payment',
        input: const {'amount': 10},
        grants: grants([const PermissionGrant(capability: 'MAKE_PAYMENT', granted: true, autonomous: true)]),
      );
      expect(d.verdict, Verdict.requireApproval);
      expect(d.reason, DecisionReason.highRiskAlwaysConfirm);
      expect(d.requiresBiometric, isTrue);
    });
  });
}
