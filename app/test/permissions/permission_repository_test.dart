import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/agent/firewall.dart';
import 'package:life_os/core/agent/tool_contract.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/permissions/permission_repository.dart';

void main() {
  final registry = ToolRegistry.fromContractJson(File('assets/contracts/agent-tools.json').readAsStringSync());
  late LifeDatabase db;
  late PermissionRepository repo;

  setUp(() async {
    db = LifeDatabase(NativeDatabase.memory());
    repo = PermissionRepository(db, registry, clock: () => DateTime(2026, 9, 22));
    await repo.seedDefaults();
  });
  tearDown(() => db.close());

  Future<List<String>> auditActions() async => (await db.select(db.auditLogs).get()).map((a) => a.action).toList();

  test('defaults grant every capability and make every action ask first', () async {
    final grants = await repo.grants();
    expect(grants.keys.toSet(), registry.all.map((t) => t.capability).toSet());
    expect(grants.values.every((g) => g.granted && !g.autonomous), isTrue);
    expect(await auditActions(), ['permissions_seeded']);
  });

  test('seeding again never overwrites the user\'s choices', () async {
    await repo.setGranted('READ_DOCUMENTS', false);
    await repo.seedDefaults();
    expect((await repo.grants())['READ_DOCUMENTS']!.granted, isFalse);
    expect((await auditActions()).where((a) => a == 'permissions_seeded'), hasLength(1));
  });

  test('changes are audited with the capability as target', () async {
    await repo.setGranted('CREATE_TASK', false);
    await repo.setGranted('CREATE_TASK', true);
    await repo.setAskFirst('CREATE_TASK', false);
    final rows = await db.select(db.auditLogs).get();
    expect(rows.skip(1).map((r) => '${r.action}:${r.targetId}'),
        ['permission_revoked:CREATE_TASK', 'permission_granted:CREATE_TASK', 'ask_first_off:CREATE_TASK']);
  });

  test('stored grants drive the firewall', () async {
    final firewall = PermissionFirewall(registry);
    Future<Verdict> createTask() async =>
        firewall.evaluate(toolName: 'create_task', input: const {'title': 'x'}, grants: await repo.grants()).verdict;

    expect(await createTask(), Verdict.requireApproval);
    await repo.setAskFirst('CREATE_TASK', false);
    expect(await createTask(), Verdict.allow);
    await repo.setGranted('CREATE_TASK', false);
    expect(await createTask(), Verdict.block);
  });

  test('high-risk capabilities can never stop asking first', () async {
    final withPayment = ToolRegistry([
      ...registry.all,
      const ToolDef(
        name: 'make_payment',
        description: 't',
        capability: 'MAKE_PAYMENT',
        effect: ToolEffect.commit,
        risk: RiskTier.high,
        inputSchema: {'type': 'object'},
      ),
    ]);
    final r = PermissionRepository(db, withPayment);
    await r.seedDefaults();
    expect(r.capabilities.firstWhere((c) => c.capability == 'MAKE_PAYMENT').autonomyAllowed, isFalse);
    expect(() => r.setAskFirst('MAKE_PAYMENT', false), throwsStateError);
  });

  test('unknown capabilities are rejected', () {
    expect(() => repo.setGranted('SEND_EMAIL', true), throwsStateError);
  });
}
