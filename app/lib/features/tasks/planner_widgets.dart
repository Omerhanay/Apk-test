import 'package:flutter/material.dart';

import '../../core/time/recurrence.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

/// Shows and edits a due date. Tapping picks a date, then optionally a time;
/// dismissing the time picker makes it all-day.
class DueChip extends StatelessWidget {
  const DueChip({super.key, required this.due, required this.allDay, required this.now, required this.onChanged});

  final DateTime? due;
  final bool allDay;
  final DateTime now;
  final void Function(DateTime? due, bool allDay) onChanged;

  Future<void> _pick(BuildContext context) async {
    final initial = due ?? now;
    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 10),
    );
    if (date == null || !context.mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: allDay || due == null ? const TimeOfDay(hour: 9, minute: 0) : TimeOfDay.fromDateTime(initial),
    );
    onChanged(
      time == null ? DateTime(date.year, date.month, date.day) : DateTime(date.year, date.month, date.day, time.hour, time.minute),
      time == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return InputChip(
      avatar: const Icon(Icons.event_outlined, size: 18),
      label: Text(due == null ? l.quickAddNoDate : dueLabel(l, locale, due!, allDay: allDay, now: now)),
      onPressed: () => _pick(context),
      onDeleted: due == null ? null : () => onChanged(null, false),
      deleteButtonTooltipMessage: l.quickAddClearDate,
    );
  }
}

class RepeatChip extends StatelessWidget {
  const RepeatChip({super.key, required this.value, required this.onChanged});

  final Recurrence? value;
  final ValueChanged<Recurrence?> onChanged;

  static const _options = <Recurrence?>[
    null,
    Recurrence(Frequency.daily),
    Recurrence(Frequency.weekly),
    Recurrence(Frequency.monthly),
    Recurrence(Frequency.yearly),
  ];

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PopupMenuButton<int>(
      tooltip: l.quickAddRepeatTooltip,
      onSelected: (i) => onChanged(_options[i]),
      itemBuilder: (_) => [
        for (var i = 0; i < _options.length; i++) PopupMenuItem(value: i, child: Text(recurrenceLabel(l, _options[i]))),
      ],
      child: Chip(
        avatar: const Icon(Icons.repeat, size: 18),
        label: Text(recurrenceLabel(l, value)),
      ),
    );
  }
}
