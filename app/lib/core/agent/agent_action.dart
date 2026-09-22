import '../db/tables.dart' show ActionState;
import 'canonical_json.dart' as cj;

export '../db/tables.dart' show ActionState;

class IllegalActionTransition implements Exception {
  IllegalActionTransition(this.from, this.to);
  final ActionState from;
  final ActionState to;

  @override
  String toString() => 'IllegalActionTransition($from -> $to)';
}

class ApprovalMismatch implements Exception {
  @override
  String toString() => 'ApprovalMismatch: approval does not match the previewed arguments';
}

/// Lifecycle of one proposed side effect.
///
///   proposed ─┬─▶ blocked
///             ├─▶ awaitingApproval ─┬─▶ approved ─▶ executing ─┬─▶ verified
///             │                     └─▶ rejected               └─▶ failed
///             └─▶ approved (autonomy granted)
///
/// Only `verified` may be reported to the user or model as done.
class AgentAction {
  AgentAction({required this.id, required this.tool, required Map<String, dynamic> args})
      : args = Map.unmodifiable(args),
        argsHash = cj.argsHash(tool, args);

  final String id;
  final String tool;
  final Map<String, dynamic> args;
  final String argsHash;

  ActionState _state = ActionState.proposed;
  ActionState get state => _state;

  String? errorCode;

  static const _allowed = <ActionState, Set<ActionState>>{
    ActionState.proposed: {ActionState.blocked, ActionState.awaitingApproval, ActionState.approved},
    ActionState.awaitingApproval: {ActionState.approved, ActionState.rejected},
    ActionState.approved: {ActionState.executing},
    ActionState.executing: {ActionState.verified, ActionState.failed},
  };

  void _to(ActionState next) {
    if (!(_allowed[_state]?.contains(next) ?? false)) throw IllegalActionTransition(_state, next);
    _state = next;
  }

  void block() => _to(ActionState.blocked);
  void requestApproval() => _to(ActionState.awaitingApproval);

  /// Autonomous path: firewall allowed it without a per-action approval.
  void autoApprove() {
    if (_state != ActionState.proposed) throw IllegalActionTransition(_state, ActionState.approved);
    _to(ActionState.approved);
  }

  /// User approval from the preview UI. [previewedHash] is the hash of what
  /// the user saw; any change to the arguments invalidates it.
  void approve(String previewedHash) {
    if (previewedHash != argsHash) throw ApprovalMismatch();
    _to(ActionState.approved);
  }

  void reject() => _to(ActionState.rejected);
  void startExecution() => _to(ActionState.executing);
  void markVerified() => _to(ActionState.verified);

  void markFailed(String code) {
    _to(ActionState.failed);
    errorCode = code;
  }

  /// Outcome string returned to the model as the tool result.
  String get outcome => switch (_state) {
        ActionState.verified => 'created',
        ActionState.awaitingApproval => 'awaiting_approval',
        ActionState.blocked => 'blocked',
        ActionState.rejected => 'rejected_by_user',
        ActionState.failed => 'failed',
        _ => 'not_completed',
      };
}
