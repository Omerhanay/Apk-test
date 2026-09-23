import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/planner/planner_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../tasks/tasks_screen.dart';

/// Answers three questions: what is happening, what needs attention, and what
/// LIFE OS can do. Everything shown comes from local data.
class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final now = ref.watch(clockProvider)();
    final repo = ref.watch(plannerRepositoryProvider).value;
    final start = DateTime(now.year, now.month, now.day);
    final end = DateTime(now.year, now.month, now.day + 1);

    return ListView(
      padding: const EdgeInsets.only(bottom: Gap.xl),
      children: [
        TodayHeader(now: now),
        if (repo != null)
          StreamBuilder<List<Task>>(
            stream: repo.watchOpenTasks(),
            builder: (context, tasks) => StreamBuilder<List<Event>>(
              stream: repo.watchEventsBetween(start, end),
              builder: (context, events) {
                if (!tasks.hasData || !events.hasData) return const SizedBox.shrink();
                final b = bucketTasks(tasks.data!, now);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SectionHeader(l.todayHappening),
                    if (events.data!.isEmpty && b.today.isEmpty)
                      EmptyState(
                        icon: Icons.event_outlined,
                        title: l.todayNothingScheduledTitle,
                        message: l.todayNothingScheduledBody,
                      )
                    else ...[
                      for (final e in events.data!) _EventTile(event: e),
                      for (final t in b.today) TaskTile(task: t),
                    ],
                    SectionHeader(l.todayAttention),
                    if (b.overdue.isEmpty)
                      EmptyState(icon: Icons.notifications_none, title: l.todayAllClearTitle, message: l.todayAllClearBody)
                    else ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.s),
                        child: Text(l.todayOverdue(b.overdue.length), style: Theme.of(context).textTheme.titleSmall),
                      ),
                      for (final t in b.overdue) TaskTile(task: t, overdue: true),
                    ],
                  ],
                );
              },
            ),
          ),
      ],
    );
  }
}

class TodayHeader extends StatelessWidget {
  const TodayHeader({super.key, required this.now});
  final DateTime now;

  static String greetingFor(DateTime t, AppLocalizations l) => switch (t.hour) {
        < 5 => l.greetingEvening,
        < 12 => l.greetingMorning,
        < 18 => l.greetingAfternoon,
        _ => l.greetingEvening,
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(greetingFor(now, l), style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: Gap.xs),
          Text(DateFormat.MMMMEEEEd(locale).format(now),
              style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final theme = Theme.of(context);
    return ListTile(
      leading: SizedBox(
        width: 48,
        child: Center(
          child: Text(DateFormat.Hm(locale).format(event.startsAt),
              style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
        ),
      ),
      title: Text(event.title),
      subtitle: event.location == null ? null : Text(event.location!),
    );
  }
}
