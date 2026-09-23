import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/planner/planner_repository.dart';
import '../../core/providers.dart';
import '../../core/time/recurrence.dart';
import '../../l10n/app_localizations.dart';
import 'planner_widgets.dart';

Future<void> showTaskEditSheet(BuildContext context, Task task) {
  // A stale confirmation must not cover the sheet's buttons.
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => TaskEditSheet(task: task),
  );
}

class TaskEditSheet extends ConsumerStatefulWidget {
  const TaskEditSheet({super.key, required this.task});
  final Task task;

  @override
  ConsumerState<TaskEditSheet> createState() => _TaskEditSheetState();
}

class _TaskEditSheetState extends ConsumerState<TaskEditSheet> {
  late final _title = TextEditingController(text: widget.task.title);
  late final _notes = TextEditingController(text: widget.task.notes ?? '');
  late DateTime? _due = widget.task.dueAt;
  late bool _allDay = widget.task.allDay;
  late Recurrence? _repeat = Recurrence.parse(widget.task.recurrenceRule);
  bool _remind = true;

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_title.text.trim().isEmpty) return;
    final repo = await ref.read(plannerRepositoryProvider.future);
    await repo.updateTask(
      widget.task.id,
      TaskDraft(
        title: _title.text,
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        due: _due,
        allDay: _allDay,
        priority: widget.task.priority,
        recurrence: _due == null ? null : _repeat,
        remind: _remind,
      ),
    );
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final l = AppLocalizations.of(context);
    final repo = await ref.read(plannerRepositoryProvider.future);
    await repo.deleteTask(widget.task.id);
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.taskDeleted)));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _title,
              decoration: InputDecoration(labelText: l.quickAddTask),
            ),
            const SizedBox(height: Gap.m),
            TextField(
              controller: _notes,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(labelText: l.taskNotes),
            ),
            const SizedBox(height: Gap.m),
            Wrap(
              spacing: Gap.s,
              runSpacing: Gap.s,
              children: [
                DueChip(
                  due: _due,
                  allDay: _allDay,
                  now: ref.read(clockProvider)(),
                  onChanged: (due, allDay) => setState(() {
                    _due = due;
                    _allDay = allDay;
                  }),
                ),
                if (_due != null)
                  RepeatChip(
                    value: _repeat,
                    onChanged: (r) => setState(() => _repeat = r),
                  ),
              ],
            ),
            if (_due != null)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(l.quickAddRemind),
                value: _remind,
                onChanged: (v) => setState(() => _remind = v),
              ),
            const SizedBox(height: Gap.l),
            FilledButton(
              onPressed: _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(l.taskSave),
            ),
            const SizedBox(height: Gap.s),
            TextButton.icon(
              onPressed: _delete,
              icon: const Icon(Icons.delete_outline),
              label: Text(l.taskDelete),
            ),
          ],
        ),
      ),
    );
  }
}
