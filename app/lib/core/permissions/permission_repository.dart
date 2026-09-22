import 'package:drift/drift.dart';

import '../agent/firewall.dart';
import '../agent/tool_contract.dart';
import '../db/database.dart';

/// One user-facing permission: a capability and the strongest tool behind it.
class CapabilityInfo {
  const CapabilityInfo(this.capability, this.effect, this.risk);
  final String capability;
  final ToolEffect effect;
  final RiskTier risk;

  bool get isAction => effect == ToolEffect.commit;

  /// High-risk actions (payments, purchases) can never run without asking.
  bool get autonomyAllowed => isAction && risk != RiskTier.high;
}

/// Reads and changes permission grants. Every change is audited.
class PermissionRepository {
  PermissionRepository(this._db, this._registry, {DateTime Function()? clock}) : _now = clock ?? DateTime.now;

  final LifeDatabase _db;
  final ToolRegistry _registry;
  final DateTime Function() _now;

  List<CapabilityInfo> get capabilities {
    final byCap = <String, CapabilityInfo>{};
    for (final tool in _registry.all) {
      final existing = byCap[tool.capability];
      if (existing == null ||
          tool.effect.index > existing.effect.index ||
          (tool.effect == existing.effect && tool.risk.index > existing.risk.index)) {
        byCap[tool.capability] = CapabilityInfo(tool.capability, tool.effect, tool.risk);
      }
    }
    return byCap.values.toList();
  }

  /// First-run defaults: every capability on, and every action asks first.
  /// Existing choices are never overwritten.
  Future<void> seedDefaults() async {
    final existing = (await _db.select(_db.permissions).get()).map((p) => p.capability).toSet();
    final missing = capabilities.where((c) => !existing.contains(c.capability)).toList();
    if (missing.isEmpty) return;
    final now = _now();
    await _db.transaction(() async {
      for (final c in missing) {
        await _db.into(_db.permissions).insert(PermissionsCompanion.insert(
              capability: c.capability,
              granted: true,
              grantedVia: 'default',
              grantedAt: now,
            ));
      }
      await _db.audit(actor: 'system', action: 'permissions_seeded', outcome: 'ok', at: now);
    });
  }

  Stream<List<PermissionGrantRow>> watch() => _db.select(_db.permissions).watch();

  /// Current grants in the shape the firewall consumes.
  Future<Map<String, PermissionGrant>> grants() async => {
        for (final row in await _db.select(_db.permissions).get())
          row.capability: PermissionGrant(
            capability: row.capability,
            granted: row.granted,
            autonomous: row.autonomous,
            expiresAt: row.expiresAt,
          ),
      };

  Future<void> setGranted(String capability, bool granted) => _change(
        capability,
        PermissionsCompanion(granted: Value(granted), grantedVia: const Value('user'), grantedAt: Value(_now())),
        granted ? 'permission_granted' : 'permission_revoked',
      );

  Future<void> setAskFirst(String capability, bool askFirst) {
    final info = capabilities.firstWhere((c) => c.capability == capability);
    if (!askFirst && !info.autonomyAllowed) {
      throw StateError('$capability cannot run without asking');
    }
    return _change(
      capability,
      PermissionsCompanion(autonomous: Value(!askFirst), grantedVia: const Value('user')),
      askFirst ? 'ask_first_on' : 'ask_first_off',
    );
  }

  Future<void> _change(String capability, PermissionsCompanion change, String auditAction) {
    return _db.transaction(() async {
      final updated = await (_db.update(_db.permissions)..where((p) => p.capability.equals(capability))).write(change);
      if (updated != 1) throw StateError('Unknown capability $capability');
      await _db.audit(
        actor: 'user',
        action: auditAction,
        outcome: 'ok',
        targetType: 'capability',
        targetId: capability,
        at: _now(),
      );
    });
  }
}
