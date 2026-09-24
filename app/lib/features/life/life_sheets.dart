import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/design/theme.dart';
import '../../core/life/life_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

const _leadOptions = <int?>[null, 1, 3, 7, 14, 30, 60];

Future<T?> _sheet<T>(BuildContext context, Widget child) {
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    useSafeArea: true,
    builder: (_) => child,
  );
}

/// The Life tab's add button: a person or a thing.
Future<void> showLifeAddChooser(BuildContext context) async {
  final l = AppLocalizations.of(context);
  final choice = await _sheet<String>(
    context,
    SafeArea(
      child: Builder(
        builder: (context) => Column(mainAxisSize: MainAxisSize.min, children: [
          ListTile(
            leading: const Icon(Icons.person_add_alt_outlined),
            title: Text(l.lifeAddPerson),
            onTap: () => Navigator.pop(context, 'person'),
          ),
          ListTile(
            leading: const Icon(Icons.add_home_work_outlined),
            title: Text(l.lifeAddThing),
            onTap: () => Navigator.pop(context, 'thing'),
          ),
          const SizedBox(height: Gap.s),
        ]),
      ),
    ),
  );
  if (!context.mounted) return;
  switch (choice) {
    case 'person':
      await showPersonSheet(context);
    case 'thing':
      await showThingSheet(context);
  }
}

Future<void> showPersonSheet(BuildContext context) => _sheet<void>(context, const PersonSheet());
Future<void> showThingSheet(BuildContext context) => _sheet<void>(context, const ThingSheet());

/// Picks one date for a person or thing. Returns null if dismissed.
Future<DateDraft?> showDateSheet(BuildContext context, {bool forThing = true}) =>
    _sheet<DateDraft>(context, DateSheet(forThing: forThing));

Widget _leadDropdown(AppLocalizations l, int? value, ValueChanged<int?> onChanged) => DropdownButtonFormField<int?>(
      initialValue: value,
      items: [
        for (final d in _leadOptions)
          DropdownMenuItem(value: d, child: Text(d == null ? l.lifeNoReminder : l.docRemindBefore(d))),
      ],
      onChanged: onChanged,
    );

Widget _saveButton(String label, VoidCallback? onPressed) => Padding(
      padding: const EdgeInsets.only(top: Gap.l),
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
        child: Text(label),
      ),
    );

class PersonSheet extends ConsumerStatefulWidget {
  const PersonSheet({super.key});

  @override
  ConsumerState<PersonSheet> createState() => _PersonSheetState();
}

class _PersonSheetState extends ConsumerState<PersonSheet> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  String _relation = 'child';
  DateTime? _birthday;
  bool _yearUnknown = false;
  int? _lead = 7;
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    final now = ref.read(clockProvider)();
    final picked = await showDatePicker(
      context: context,
      initialDate: _birthday ?? DateTime(now.year - 30, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked != null) setState(() => _birthday = picked);
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final router = GoRouter.of(context);
    setState(() => _saving = true);
    final repo = await ref.read(lifeRepositoryProvider.future);
    final id = await repo.addPerson(
      name: _name.text,
      relation: _relation,
      birthday: _birthday,
      birthYearKnown: !_yearUnknown,
      remindDaysBefore: _lead,
      notes: _notes.text,
      titleFor: lifeReminderTitle(l, locale),
    );
    if (_birthday != null && _lead != null) await (await ref.read(notificationSchedulerProvider.future)).requestPermission();
    if (!mounted) return;
    Navigator.pop(context);
    router.push('/life/$id');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return _SheetBody(children: [
      Text(l.lifeAddPerson, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: Gap.m),
      TextField(
        controller: _name,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(labelText: l.lifeName),
        onChanged: (_) => setState(() {}),
      ),
      const SizedBox(height: Gap.m),
      DropdownButtonFormField<String>(
        initialValue: _relation,
        decoration: InputDecoration(labelText: l.lifeRelation),
        items: [for (final r in personRelations) DropdownMenuItem(value: r, child: Text(relationLabel(l, r)))],
        onChanged: (r) => setState(() => _relation = r ?? 'other'),
      ),
      const SizedBox(height: Gap.m),
      Align(
        alignment: Alignment.centerLeft,
        child: InputChip(
          avatar: const Icon(Icons.cake_outlined, size: 18),
          label: Text(_birthday == null
              ? l.lifeSetBirthday
              : (_yearUnknown ? DateFormat.MMMMd(locale) : DateFormat.yMMMMd(locale)).format(_birthday!)),
          onPressed: _pickBirthday,
          onDeleted: _birthday == null ? null : () => setState(() => _birthday = null),
        ),
      ),
      if (_birthday != null) ...[
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          value: _yearUnknown,
          onChanged: (v) => setState(() => _yearUnknown = v ?? false),
          title: Text(l.lifeBirthYearUnknown),
        ),
        _leadDropdown(l, _lead, (v) => setState(() => _lead = v)),
      ],
      const SizedBox(height: Gap.m),
      TextField(controller: _notes, minLines: 1, maxLines: 4, decoration: InputDecoration(labelText: l.taskNotes)),
      _saveButton(l.taskSave, _name.text.trim().isEmpty || _saving ? null : _save),
    ]);
  }
}

class ThingSheet extends ConsumerStatefulWidget {
  const ThingSheet({super.key});

  @override
  ConsumerState<ThingSheet> createState() => _ThingSheetState();
}

class _ThingSheetState extends ConsumerState<ThingSheet> {
  final _name = TextEditingController();
  final _notes = TextEditingController();
  String _type = 'vehicle';
  final _dates = <DateDraft>[];
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_name.text.trim().isEmpty) return;
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final router = GoRouter.of(context);
    setState(() => _saving = true);
    final repo = await ref.read(lifeRepositoryProvider.future);
    final id = await repo.addThing(
      name: _name.text,
      type: _type,
      notes: _notes.text,
      dates: _dates,
      titleFor: lifeReminderTitle(l, locale),
    );
    if (_dates.any((d) => d.remindDaysBefore != null)) {
      await (await ref.read(notificationSchedulerProvider.future)).requestPermission();
    }
    if (!mounted) return;
    Navigator.pop(context);
    router.push('/life/$id');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return _SheetBody(children: [
      Text(l.lifeAddThing, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: Gap.m),
      TextField(
        controller: _name,
        autofocus: true,
        decoration: InputDecoration(labelText: l.lifeName),
        onChanged: (_) => setState(() {}),
      ),
      const SizedBox(height: Gap.m),
      DropdownButtonFormField<String>(
        initialValue: _type,
        decoration: InputDecoration(labelText: l.docType),
        items: [for (final t in thingTypes) DropdownMenuItem(value: t, child: Text(thingTypeLabel(l, t)))],
        onChanged: (t) => setState(() => _type = t ?? 'other'),
      ),
      const SizedBox(height: Gap.s),
      for (var i = 0; i < _dates.length; i++)
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event_outlined),
          title: Text(dateKindLabel(l, _dates[i].kind)),
          subtitle: Text([
            DateFormat.yMMMd(locale).format(_dates[i].date),
            if (_dates[i].yearly) l.repeatYearly,
            if (_dates[i].remindDaysBefore != null) l.docRemindBefore(_dates[i].remindDaysBefore!),
          ].join(' · ')),
          trailing: IconButton(icon: const Icon(Icons.close), onPressed: () => setState(() => _dates.removeAt(i))),
        ),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () async {
            final d = await showDateSheet(context);
            if (d != null) setState(() => _dates.add(d));
          },
          icon: const Icon(Icons.add),
          label: Text(l.lifeAddDate),
        ),
      ),
      TextField(controller: _notes, minLines: 1, maxLines: 4, decoration: InputDecoration(labelText: l.taskNotes)),
      _saveButton(l.taskSave, _name.text.trim().isEmpty || _saving ? null : _save),
    ]);
  }
}

class DateSheet extends ConsumerStatefulWidget {
  const DateSheet({super.key, this.forThing = true});
  final bool forThing;

  @override
  ConsumerState<DateSheet> createState() => _DateSheetState();
}

class _DateSheetState extends ConsumerState<DateSheet> {
  late String _kind = widget.forThing ? 'inspection' : 'birthday';
  DateTime? _date;
  late bool _yearly = _kind == 'birthday';
  late int? _lead = _kind == 'birthday' ? 7 : 30;

  List<String> get _kinds => widget.forThing ? thingDateKinds : const ['birthday', 'other'];

  Future<void> _pick() async {
    final now = ref.read(clockProvider)();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 30),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return _SheetBody(children: [
      Text(l.lifeAddDate, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: Gap.m),
      DropdownButtonFormField<String>(
        initialValue: _kind,
        decoration: InputDecoration(labelText: l.lifeDateKind),
        items: [for (final k in _kinds) DropdownMenuItem(value: k, child: Text(dateKindLabel(l, k)))],
        onChanged: (k) => setState(() {
          _kind = k ?? 'other';
          if (_kind == 'birthday') _yearly = true;
        }),
      ),
      const SizedBox(height: Gap.m),
      Align(
        alignment: Alignment.centerLeft,
        child: InputChip(
          avatar: const Icon(Icons.event_outlined, size: 18),
          label: Text(_date == null ? l.lifePickDate : DateFormat.yMMMMd(locale).format(_date!)),
          onPressed: _pick,
        ),
      ),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(l.repeatYearly),
        value: _yearly,
        onChanged: (v) => setState(() => _yearly = v),
      ),
      _leadDropdown(l, _lead, (v) => setState(() => _lead = v)),
      _saveButton(
        l.quickAddSave,
        _date == null
            ? null
            : () => Navigator.pop(context, DateDraft(kind: _kind, date: _date!, yearly: _yearly, remindDaysBefore: _lead)),
      ),
    ]);
  }
}

class _SheetBody extends StatelessWidget {
  const _SheetBody({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.l),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, mainAxisSize: MainAxisSize.min, children: children),
        ),
      );
}
