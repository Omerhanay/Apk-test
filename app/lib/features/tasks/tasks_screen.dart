import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/database.dart';
import '../../core/design/widgets.dart';
import '../../core/planner/planner_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';
import 'task_edit_sheet.dart';

class TasksScreen extends ConsumerWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final repo = ref.watch(plannerRepositoryProvider);

    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [Tab(text: l.tasksTabToday), Tab(text: l.tasksTabUpcoming), Tab(text: l.tasksTabSomeday)]),
          Expanded(
            child: repo.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (repo) => StreamBuilder<List<Task>>(
                stream: repo.watchOpenTasks(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const SizedBox.shrink();
                  final b = bucketTasks(snapshot.data!, ref.read(clockProvider)());
                  return TabBarView(
                    children: [
                      b.overdue.isEmpty && b.today.isEmpty
                          ? EmptyState(icon: Icons.check_circle_outline, title: l.tasksEmptyTodayTitle, message: l.tasksEmptyTodayBody)
                          : ListView(
                              padding: const EdgeInsets.only(bottom: 96),
                              children: [
                                if (b.overdue.isNotEmpty) ...[
                                  SectionHeader(l.tasksOverdueHeader),
                                  for (final t in b.overdue) TaskTile(task: t, overdue: true),
                                ],
                                if (b.today.isNotEmpty) ...[
                                  SectionHeader(l.tasksTodayHeader),
                                  for (final t in b.today) TaskTile(task: t),
                                ],
                              ],
                            ),
                      _list(b.upcoming, EmptyState(icon: Icons.upcoming_outlined, title: l.tasksEmptyUpcomingTitle, message: l.tasksEmptyUpcomingBody)),
                      _list(b.someday, EmptyState(icon: Icons.inbox_outlined, title: l.tasksEmptySomedayTitle, message: l.tasksEmptySomedayBody)),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _list(List<Task> tasks, Widget empty) => tasks.isEmpty
      ? empty
      : ListView(padding: const EdgeInsets.only(bottom: 96), children: [for (final t in tasks) TaskTile(task: t)]);
}

/// One open task with a checkbox. Completing offers Undo, which also removes
/// the next occurrence of a repeating task.
class TaskTile extends ConsumerWidget {
  const TaskTile({super.key, required this.task, this.overdue = false});
  final Task task;
  final bool overdue;

  Future<void> _complete(BuildContext context, WidgetRef ref) async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final messenger = ScaffoldMessenger.of(context);
    final repo = await ref.read(plannerRepositoryProvider.future);
    final nextId = await repo.completeTask(task.id);
    final next = nextId == null ? null : await repo.task(nextId);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(next?.dueAt == null
            ? l.taskDone
            : l.taskNextOccurrence(dueLabel(l, locale, next!.dueAt!, allDay: next.allDay, now: ref.read(clockProvider)()))),
        action: SnackBarAction(
          label: l.taskUndo,
          onPressed: () async {
            if (nextId != null) await repo.deleteTask(nextId);
            await repo.reopenTask(task.id);
          },
        ),
      ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final due = task.dueAt;
    return ListTile(
      leading: Checkbox(value: false, onChanged: (_) => _complete(context, ref)),
      title: Text(task.title),
      subtitle: due == null
          ? null
          : Row(children: [
              Text(
                dueLabel(l, locale, due, allDay: task.allDay, now: ref.read(clockProvider)()),
                style: overdue ? TextStyle(color: theme.colorScheme.error) : null,
              ),
              if (task.recurrenceRule != null) ...[
                const SizedBox(width: 6),
                Icon(Icons.repeat, size: 14, color: theme.colorScheme.onSurfaceVariant),
              ],
            ]),
      onTap: () => showTaskEditSheet(context, task),
    );
  }
}
