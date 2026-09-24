import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design/theme.dart';
import '../../core/providers.dart';
import '../../core/security/app_lock.dart';
import '../../core/security/authenticator.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

/// Shows the app only when unlocked. Before that it shows the first-run welcome
/// or the lock screen, so no personal data is built into the widget tree.
class LockGate extends ConsumerStatefulWidget {
  const LockGate({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<LockGate> createState() => _LockGateState();
}

class _LockGateState extends ConsumerState<LockGate> with WidgetsBindingObserver {
  AuthOutcome? _lastOutcome;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final lock = ref.read(appLockProvider.notifier);
    switch (state) {
      case AppLifecycleState.paused || AppLifecycleState.hidden:
        lock.onBackgrounded();
      case AppLifecycleState.resumed:
        lock.onResumed();
      default:
        break;
    }
  }

  Future<void> _unlock() async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final outcome = await ref.read(appLockProvider.notifier).unlock(l.lockReason);
    if (!mounted) return;
    setState(() => _lastOutcome = outcome);
    if (outcome == AuthOutcome.success) {
      if (!ref.read(onboardedProvider)) await ref.read(onboardedProvider.notifier).complete();
      final db = await ref.read(databaseProvider.future);
      await db.audit(actor: 'user', action: 'app_unlocked', outcome: 'ok');
      // Creates first-run default permissions, so the firewall never runs on an empty grant table.
      await ref.read(permissionRepositoryProvider.future);
      // Each reminder fires once; re-arm birthdays and other yearly dates.
      final life = await ref.read(lifeRepositoryProvider.future);
      await life.ensureUpcomingReminders(titleFor: lifeReminderTitle(l, locale));
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(appLockProvider);
    if (status == LockStatus.unlocked) return widget.child;

    final onboarded = ref.watch(onboardedProvider);
    return _LockedView(
      onboarding: !onboarded,
      busy: status == LockStatus.unlocking,
      lastOutcome: _lastOutcome,
      onUnlock: _unlock,
    );
  }
}

class _LockedView extends StatelessWidget {
  const _LockedView({required this.onboarding, required this.busy, required this.lastOutcome, required this.onUnlock});

  final bool onboarding;
  final bool busy;
  final AuthOutcome? lastOutcome;
  final VoidCallback onUnlock;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final message = switch (lastOutcome) {
      AuthOutcome.noCredential => l.lockNoCredential,
      AuthOutcome.lockedOut => l.lockLockedOut,
      AuthOutcome.failed => l.lockFailed,
      _ => null,
    };

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, Gap.xl, 28, Gap.l),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(onboarding ? Icons.spa_outlined : Icons.lock_outline, size: 40, color: theme.colorScheme.primary),
              const SizedBox(height: Gap.l),
              Text(
                onboarding ? l.onboardingTitle : l.lockTitle,
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (onboarding) ...[
                const SizedBox(height: Gap.l),
                _Principle(Icons.phone_android, l.onboardingPrivate),
                _Principle(Icons.front_hand_outlined, l.onboardingAsks),
                _Principle(Icons.fact_check_outlined, l.onboardingSources),
              ],
              const Spacer(),
              if (message != null) ...[
                Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
                const SizedBox(height: Gap.m),
              ],
              FilledButton(
                onPressed: busy ? null : onUnlock,
                style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
                child: Text(onboarding ? l.onboardingContinue : l.lockUnlock),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Principle extends StatelessWidget {
  const _Principle(this.icon, this.text);
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Gap.s),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 22, color: theme.colorScheme.onSurfaceVariant),
          const SizedBox(width: Gap.m),
          Expanded(child: Text(text, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
