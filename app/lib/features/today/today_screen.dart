import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../l10n/app_localizations.dart';

/// Answers three questions: what is happening, what needs attention, and what
/// LIFE OS can do. Sections fill from local data as later phases land.
class TodayScreen extends StatelessWidget {
  const TodayScreen({super.key, this.now});

  /// Injectable for tests.
  final DateTime? now;

  static String greetingFor(DateTime t, AppLocalizations l) => switch (t.hour) {
        < 5 => l.greetingEvening,
        < 12 => l.greetingMorning,
        < 18 => l.greetingAfternoon,
        _ => l.greetingEvening,
      };

  @override
  Widget build(BuildContext context) {
    final t = now ?? DateTime.now();
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();

    return ListView(
      padding: const EdgeInsets.only(bottom: Gap.xl),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(greetingFor(t, l), style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: Gap.xs),
              Text(DateFormat.MMMMEEEEd(locale).format(t),
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            ],
          ),
        ),
        SectionHeader(l.todayHappening),
        EmptyState(
          icon: Icons.event_outlined,
          title: l.todayNothingScheduledTitle,
          message: l.todayNothingScheduledBody,
        ),
        SectionHeader(l.todayAttention),
        EmptyState(
          icon: Icons.notifications_none,
          title: l.todayAllClearTitle,
          message: l.todayAllClearBody,
        ),
      ],
    );
  }
}
