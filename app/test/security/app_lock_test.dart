import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/providers.dart';
import 'package:life_os/core/security/app_lock.dart';
import 'package:life_os/core/security/authenticator.dart';
import 'package:life_os/core/security/key_store.dart';

import '../ui/test_app.dart';

void main() {
  late FakeAuthenticator auth;
  late DateTime now;
  late ProviderContainer container;

  setUp(() {
    auth = FakeAuthenticator();
    now = DateTime(2026, 9, 22, 9);
    container = ProviderContainer(overrides: [
      authenticatorProvider.overrideWithValue(auth),
      clockProvider.overrideWithValue(() => now),
    ]);
    addTearDown(container.dispose);
  });

  AppLockController lock() => container.read(appLockProvider.notifier);
  LockStatus status() => container.read(appLockProvider);

  test('starts locked and unlocks only on successful authentication', () async {
    expect(status(), LockStatus.locked);

    for (final failure in [AuthOutcome.cancelled, AuthOutcome.failed, AuthOutcome.lockedOut, AuthOutcome.noCredential]) {
      auth.outcome = failure;
      expect(await lock().unlock('r'), failure);
      expect(status(), LockStatus.locked, reason: '$failure');
    }

    auth.outcome = AuthOutcome.success;
    await lock().unlock('r');
    expect(status(), LockStatus.unlocked);
  });

  test('stays unlocked for a short trip to the background', () async {
    await lock().unlock('r');
    lock().onBackgrounded();
    now = now.add(const Duration(seconds: 29));
    lock().onResumed();
    expect(status(), LockStatus.unlocked);
  });

  test('locks again after the grace period in the background', () async {
    await lock().unlock('r');
    lock().onBackgrounded();
    now = now.add(AppLockController.gracePeriod);
    lock().onResumed();
    expect(status(), LockStatus.locked);
  });

  test('repeated background events keep the first timestamp', () async {
    await lock().unlock('r');
    lock().onBackgrounded(); // paused
    now = now.add(AppLockController.gracePeriod);
    lock().onBackgrounded(); // hidden, on the way back
    lock().onResumed();
    expect(status(), LockStatus.locked);
  });

  test('the system auth dialog does not count as backgrounding', () async {
    lock().onBackgrounded(); // still locked: ignored
    now = now.add(const Duration(minutes: 5));
    await lock().unlock('r');
    lock().onResumed();
    expect(status(), LockStatus.unlocked);
  });

  test('ignores a second unlock while one is in progress', () async {
    final first = lock().unlock('r');
    expect(status(), LockStatus.unlocking);
    expect(await lock().unlock('r'), AuthOutcome.cancelled);
    await first;
    expect(auth.calls, 1);
  });

  group('KeyStore', () {
    test('creates the database key once and keeps it', () async {
      final keys = KeyStore(MemorySecretStore());
      final k1 = await keys.databaseKey();
      expect(k1, matches(RegExp(r'^[0-9a-f]{64}$')));
      expect(await keys.databaseKey(), k1);
    });

    test('refuses insecure or weak relay credentials', () async {
      final keys = KeyStore(MemorySecretStore());
      final token = 'x' * 40;
      expect(RelayCredentials.validate('http://relay.example', token), RelayCredentialProblem.notHttps);
      expect(RelayCredentials.validate('https://', token), RelayCredentialProblem.notHttps);
      expect(RelayCredentials.validate('https://relay.example', 'short'), RelayCredentialProblem.tokenTooShort);
      expect(() => keys.saveRelayCredentials(RelayCredentials(Uri.parse('http://relay.example'), token)), throwsArgumentError);
      expect(await keys.relayCredentials(), isNull);
    });
  });
}
