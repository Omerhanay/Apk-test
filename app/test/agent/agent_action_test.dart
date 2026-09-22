import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/agent/agent_action.dart';
import 'package:life_os/core/agent/canonical_json.dart';

void main() {
  AgentAction action() => AgentAction(id: 'a1', tool: 'create_task', args: {'title': 'Renew', 'priority': 'high'});

  test('approval is bound to the previewed arguments', () {
    final a = action()..requestApproval();
    final tampered = argsHash('create_task', {'title': 'Renew', 'priority': 'low'});
    expect(() => a.approve(tampered), throwsA(isA<ApprovalMismatch>()));
    expect(a.state, ActionState.awaitingApproval);

    a.approve(argsHash('create_task', {'priority': 'high', 'title': 'Renew'}));
    expect(a.state, ActionState.approved);
  });

  test('hash is independent of key order', () {
    expect(argsHash('t', {'a': 1, 'b': {'y': 2, 'x': 1}}), argsHash('t', {'b': {'x': 1, 'y': 2}, 'a': 1}));
  });

  test('cannot execute without approval', () {
    final a = action()..requestApproval();
    expect(a.startExecution, throwsA(isA<IllegalActionTransition>()));
  });

  test('blocked and rejected actions are terminal', () {
    final blocked = action()..block();
    expect(() => blocked.approve(blocked.argsHash), throwsA(isA<IllegalActionTransition>()));

    final rejected = action()
      ..requestApproval()
      ..reject();
    expect(rejected.startExecution, throwsA(isA<IllegalActionTransition>()));
    expect(rejected.outcome, 'rejected_by_user');
  });

  test('only a verified action reports "created"', () {
    final a = action()..autoApprove();
    expect(a.outcome, isNot('created'));
    a.startExecution();
    expect(a.outcome, isNot('created'));
    a.markVerified();
    expect(a.outcome, 'created');
  });

  test('a failed action never reports success', () {
    final a = action()
      ..autoApprove()
      ..startExecution()
      ..markFailed('db_write_failed');
    expect(a.outcome, 'failed');
    expect(a.errorCode, 'db_write_failed');
    expect(a.markVerified, throwsA(isA<IllegalActionTransition>()));
  });

  test('arguments are immutable after proposal', () {
    final a = action();
    expect(() => a.args['title'] = 'Other', throwsUnsupportedError);
  });
}
