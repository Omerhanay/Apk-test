import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/life/life_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';
import 'life_screen.dart' show thingIcon;
import 'life_sheets.dart';

/// A person or thing: its dates, notes and what else mentions it.
class LifeEntityScreen extends ConsumerWidget {
  const LifeEntityScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(lifeRepositoryProvider).value;
    if (repo == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return StreamBuilder<LifeEntity?>(
      stream: repo.watchById(id),
      builder: (context, snap) {
        final e = snap.data;
        if (e == null) return Scaffold(appBar: AppBar());
        return _Body(repo: repo, e: e);
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.repo, required this.e});
  final LifeRepository repo;
  final LifeEntity e;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final kind = e.isPerson ? relationLabel(l, e.relation) : thingTypeLabel(l, e.entity.type);

    return Scaffold(
      appBar: AppBar(title: Text(kind)),
      body: ListView(
        padding: const EdgeInsets.only(bottom: Gap.xl),
        children: [
          ListTile(
            leading: CircleAvatar(
              child: e.isPerson
                  ? Text(e.entity.displayName.characters.first.toUpperCase())
                  : Icon(thingIcon(e.entity.type), size: 20),
            ),
            title: Text(e.entity.displayName, style: theme.textTheme.titleLarge),
            subtitle: e.notes == null ? null : Text(e.notes!, style: muted),
          ),
          SectionHeader(l.lifeDates),
          for (final d in e.dates) _dateTile(context, l, locale, d),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TextButton.icon(
                onPressed: () => _addDate(context),
                icon: const Icon(Icons.add),
                label: Text(l.lifeAddDate),
              ),
            ),
          ),
          SectionHeader(l.lifeRelated),
          _Related(repo: repo, name: e.entity.displayName),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, Gap.m, 12, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => _delete(context),
                icon: const Icon(Icons.delete_outline),
                label: Text(l.lifeDelete),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateTile(BuildContext context, AppLocalizations l, String locale, EntityDate d) {
    final next = repo.nextOccurrence(d);
    final nextText = DateFormat.yMMMMd(locale).format(next);
    final yearly = d.recurrenceRule != null;
    final age = d.kind == 'birthday' ? repo.ageOnNextBirthday(e) : null;
    final lines = [
      if (age != null) l.lifeTurns(age, DateFormat.MMMMd(locale).format(next)) else if (yearly) l.lifeNext(nextText) else nextText,
      if (yearly) l.repeatYearly,
      if (d.remindDaysBefore != null) l.docRemindBefore(d.remindDaysBefore!),
    ];
    return ListTile(
      leading: Icon(d.kind == 'birthday' ? Icons.cake_outlined : Icons.event_outlined),
      title: Text(dateKindLabel(l, d.kind)),
      subtitle: Text(lines.join(' · ')),
      trailing: IconButton(
        tooltip: l.lifeRemoveDate,
        icon: const Icon(Icons.close),
        onPressed: () => repo.removeDate(d.id),
      ),
    );
  }

  Future<void> _addDate(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final draft = await showDateSheet(context, forThing: !e.isPerson);
    if (draft == null) return;
    await repo.addDate(e.entity.id, draft, titleFor: lifeReminderTitle(l, locale));
  }

  Future<void> _delete(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.lifeDeleteConfirmTitle(e.entity.displayName)),
        content: Text(l.lifeDeleteConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.memoryCancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.lifeDelete)),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    await repo.delete(e.entity.id);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.lifeDeleted)));
  }
}

class _Related extends StatelessWidget {
  const _Related({required this.repo, required this.name});
  final LifeRepository repo;
  final String name;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return FutureBuilder(
      future: repo.related(name),
      builder: (context, snap) {
        final r = snap.data;
        if (r == null) return const SizedBox.shrink();
        final tiles = [
          for (final m in r.memories)
            ListTile(
              leading: const Icon(Icons.psychology_alt_outlined),
              title: Text(m.content, maxLines: 2, overflow: TextOverflow.ellipsis),
              onTap: () => context.push('/memory/${m.id}'),
            ),
          for (final t in r.tasks)
            ListTile(leading: const Icon(Icons.radio_button_unchecked), title: Text(t.title)),
          for (final d in r.documents)
            ListTile(
              leading: const Icon(Icons.description_outlined),
              title: Text(d.title ?? d.fileName),
              onTap: () => context.push('/documents/${d.id}'),
            ),
        ];
        if (tiles.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(l.lifeRelatedNone(name), style: Theme.of(context).textTheme.bodyMedium),
          );
        }
        return Column(children: tiles);
      },
    );
  }
}
