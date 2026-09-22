import 'package:local_auth/local_auth.dart';

enum AuthOutcome {
  success,
  cancelled,

  /// Too many failed attempts; the OS enforces a wait.
  lockedOut,

  /// The phone has no screen lock, so the app cannot be protected.
  noCredential,
  failed,
}

abstract interface class Authenticator {
  Future<AuthOutcome> authenticate(String reason);
}

/// Device authentication via BiometricPrompt. Falls back to the phone's
/// PIN/pattern/password, so a user without biometrics can still unlock.
class LocalAuthAuthenticator implements Authenticator {
  LocalAuthAuthenticator([LocalAuthentication? auth]) : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;

  @override
  Future<AuthOutcome> authenticate(String reason) async {
    try {
      if (!await _auth.isDeviceSupported()) return AuthOutcome.noCredential;
      final ok = await _auth.authenticate(localizedReason: reason, persistAcrossBackgrounding: true);
      return ok ? AuthOutcome.success : AuthOutcome.failed;
    } on LocalAuthException catch (e) {
      return switch (e.code) {
        LocalAuthExceptionCode.userCanceled || LocalAuthExceptionCode.systemCanceled || LocalAuthExceptionCode.timeout =>
          AuthOutcome.cancelled,
        LocalAuthExceptionCode.temporaryLockout || LocalAuthExceptionCode.biometricLockout => AuthOutcome.lockedOut,
        LocalAuthExceptionCode.noCredentialsSet => AuthOutcome.noCredential,
        _ => AuthOutcome.failed,
      };
    }
  }
}
