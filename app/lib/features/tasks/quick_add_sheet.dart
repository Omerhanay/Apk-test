import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design/theme.dart';
import '../../core/planner/planner_repository.dart';
import '../../core/providers.dart';
import '../../core/time/quick_add_parser.dart';
import '../../core/time/recurrence.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';
import 'planner_widgets.dart';

Future<void> showQuickAddSheet(BuildContext context) {
  // A stale confirmation must not cover the sheet's buttons.
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => const QuickAddSheet(),
  );
}

enum _Kind { task, event }

/// Adds a task or event from one line of text. The parsed title, date and
/// repetition are previewed live and can be adjusted before saving; once the
/// user sets a date or repetition by hand, typing no longer overrides it.
class QuickAddSheet extends ConsumerStatefulWidget {
  const QuickAddSheet({super.key});

  @override
  ConsumerState<QuickAddSheet> createState() => _QuickAddSheetState();
}

class _QuickAddSheetState extends ConsumerState<QuickAddSheet> {
  static const _parser = QuickAddParser();
  final _text = TextEditingController();
  _Kind _kind = _Kind.task;
  QuickAddResult? _parsed;
  ({DateTime? due, bool allDay})? _manualDue;
  ({Recurrence? value})? _manualRepeat;
  bool _remind = true;
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  DateTime get _now => ref.read(clockProvider)();
  DateTime? get _due => _manualDue != null ? _manualDue!.due : _parsed?.due;
  bool get _allDay =>
      _manualDue != null ? _manualDue!.allDay : (_parsed?.allDay ?? false);
  Recurrence? get _repeat =>
      _manualRepeat != null ? _manualRepeat!.value : _parsed?.recurrence;
  String get _title => (_parsed?.title ?? '').trim();

  void _onText(String value) => setState(() {
    _parsed = value.trim().isEmpty ? null : _parser.parse(value, _now);
    _error = null;
  });

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    if (_title.isEmpty) return;
    if (_kind == _Kind.event && (_due == null || _allDay)) {
      setState(() => _error = l.quickAddEventNeedsTime);
      return;
    }
    setState(() => _saving = true);
    final repo = await ref.read(plannerRepositoryProvider.future);
    if (_remind && _due != null) {
      final notifications = await ref.read(notificationSchedulerProvider.future);
      await notifications.requestPermission();
    }

    if (_kind == _Kind.task) {
      await repo.createTask(
        TaskDraft(
          title: _title,
          due: _due,
          allDay: _allDay,
          recurrence: _repeat,
          remind: _remind,
        ),
      );
    } else {
      await repo.createEvent(
        EventDraft(
          title: _title,
          startsAt: _due!,
          remindBefore: _remind ? const Duration(minutes: 15) : null,
        ),
      );
    }
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    Navigator.pop(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            _due == null
                ? _title
                : '$_title · ${dueLabel(l, locale, _due!, allDay: _allDay, now: _now)}',
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SegmentedButton<_Kind>(
              segments: [
                ButtonSegment(
                  value: _Kind.task,
                  label: Text(l.quickAddTask),
                  icon: const Icon(Icons.check_circle_outline),
                ),
                ButtonSegment(
                  value: _Kind.event,
                  label: Text(l.quickAddEvent),
                  icon: const Icon(Icons.event_outlined),
                ),
              ],
              selected: {_kind},
              onSelectionChanged: (s) => setState(() {
                _kind = s.first;
                _error = null;
              }),
            ),
            const SizedBox(height: Gap.m),
            TextField(
              controller: _text,
              autofocus: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: l.quickAddHint,
                hintText: l.quickAddExample,
              ),
              onChanged: _onText,
              onSubmitted: (_) => _save(),
            ),
            if (_title.isNotEmpty) ...[
              const SizedBox(height: Gap.m),
              Text(_title, style: theme.textTheme.titleMedium),
            ],
            const SizedBox(height: Gap.s),
            Wrap(
              spacing: Gap.s,
              runSpacing: Gap.s,
              children: [
                DueChip(
                  due: _due,
                  allDay: _allDay,
                  now: _now,
                  onChanged: (due, allDay) => setState(() {
                    _manualDue = (due: due, allDay: allDay);
                    _error = null;
                  }),
                ),
                if (_kind == _Kind.task)
                  RepeatChip(
                    value: _repeat,
                    onChanged: (r) =>
                        setState(() => _manualRepeat = (value: r)),
                  ),
              ],
            ),
            if (_due != null)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  _kind == _Kind.task
                      ? l.quickAddRemind
                      : l.quickAddEventRemind,
                ),
                value: _remind,
                onChanged: (v) => setState(() => _remind = v),
              ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: Gap.s),
                child: Text(
                  _error!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            const SizedBox(height: Gap.l),
            FilledButton(
              onPressed: _title.isEmpty || _saving ? null : _save,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: Text(l.quickAddSave),
            ),
          ],
        ),
      ),
    );
  }
}
