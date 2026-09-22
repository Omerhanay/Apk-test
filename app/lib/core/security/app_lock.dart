import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';
import 'authenticator.dart';

enum LockStatus { locked, unlocking, unlocked }

/// Tracks whether the UI may show personal data. The app locks at launch and
/// again when it returns from the background after [gracePeriod].
class AppLockController extends Notifier<LockStatus> {
  static const gracePeriod = Duration(seconds: 30);

  DateTime? _backgroundedAt;

  @override
  LockStatus build() => LockStatus.locked;

  Future<AuthOutcome> unlock(String reason) async {
    if (state == LockStatus.unlocked) return AuthOutcome.success;
    if (state == LockStatus.unlocking) return AuthOutcome.cancelled;
    state = LockStatus.unlocking;
    final outcome = await ref.read(authenticatorProvider).authenticate(reason);
    state = outcome == AuthOutcome.success ? LockStatus.unlocked : LockStatus.locked;
    return outcome;
  }

  void onBackgrounded() {
    // The system auth dialog also backgrounds the app, so only count it when unlocked.
    // Keep the first timestamp: returning to the foreground passes through `hidden`
    // again, and overwriting here would mean the app never relocks.
    if (state == LockStatus.unlocked) _backgroundedAt ??= ref.read(clockProvider)();
  }

  void onResumed() {
    final since = _backgroundedAt;
    _backgroundedAt = null;
    if (since != null && ref.read(clockProvider)().difference(since) >= gracePeriod) {
      state = LockStatus.locked;
    }
  }

  void lockNow() => state = LockStatus.locked;
}
