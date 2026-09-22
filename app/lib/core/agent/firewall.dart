import 'schema_validator.dart';
import 'tool_contract.dart';

/// The user's grant for one capability.
class PermissionGrant {
  const PermissionGrant({
    required this.capability,
    required this.granted,
    this.autonomous = false,
    this.expiresAt,
  });

  final String capability;
  final bool granted;

  /// Lets low/medium-risk commits run without per-action approval.
  final bool autonomous;
  final DateTime? expiresAt;

  bool activeAt(DateTime now) => granted && (expiresAt == null || now.isBefore(expiresAt!));
}

enum Verdict { allow, requireApproval, block }

/// Machine-readable reasons; shown to the user and returned to the model.
enum DecisionReason {
  readAllowed,
  autonomyGranted,
  approvalRequired,
  highRiskAlwaysConfirm,
  untrustedContext,
  unknownTool,
  invalidInput,
  permissionMissing,
  permissionExpired,
}

class FirewallDecision {
  const FirewallDecision(this.verdict, this.reason, {this.requiresBiometric = false, this.errors = const []});

  final Verdict verdict;
  final DecisionReason reason;

  /// High-risk approvals must be re-authenticated on device.
  final bool requiresBiometric;
  final List<String> errors;

  @override
  String toString() => 'FirewallDecision($verdict, $reason)';
}

/// Decides whether an agent tool call may run. This is the only path from a
/// model's tool request to a side effect; the model cannot bypass it because
/// approvals come from the UI, never from model output.
class PermissionFirewall {
  PermissionFirewall(this.registry, {DateTime Function()? clock}) : _now = clock ?? DateTime.now;

  final ToolRegistry registry;
  final DateTime Function() _now;

  FirewallDecision evaluate({
    required String toolName,
    required Map<String, dynamic> input,
    required Map<String, PermissionGrant> grants,

    /// True once the run has read untrusted text (documents, web, integrations).
    /// Such runs lose autonomy: every commit needs explicit approval.
    bool contextTainted = false,
  }) {
    final tool = registry[toolName];
    if (tool == null) return const FirewallDecision(Verdict.block, DecisionReason.unknownTool);

    final errors = validateAgainstSchema(input, tool.inputSchema);
    if (errors.isNotEmpty) {
      return FirewallDecision(Verdict.block, DecisionReason.invalidInput, errors: errors);
    }

    final grant = grants[tool.capability];
    if (grant == null || !grant.granted) {
      return const FirewallDecision(Verdict.block, DecisionReason.permissionMissing);
    }
    if (!grant.activeAt(_now())) {
      return const FirewallDecision(Verdict.block, DecisionReason.permissionExpired);
    }

    if (tool.effect != ToolEffect.commit) {
      return const FirewallDecision(Verdict.allow, DecisionReason.readAllowed);
    }

    if (tool.risk == RiskTier.high) {
      return const FirewallDecision(Verdict.requireApproval, DecisionReason.highRiskAlwaysConfirm, requiresBiometric: true);
    }
    if (contextTainted) {
      return const FirewallDecision(Verdict.requireApproval, DecisionReason.untrustedContext);
    }
    if (grant.autonomous) {
      return const FirewallDecision(Verdict.allow, DecisionReason.autonomyGranted);
    }
    return const FirewallDecision(Verdict.requireApproval, DecisionReason.approvalRequired);
  }
}
