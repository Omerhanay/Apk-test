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
import 'life_sheets.dart';

IconData thingIcon(String type) => switch (type) {
      'vehicle' => Icons.directions_car_outlined,
      'home' => Icons.home_outlined,
      'subscription' => Icons.autorenew,
      'device' => Icons.devices_other_outlined,
      'pet' => Icons.pets_outlined,
      _ => Icons.category_outlined,
    };

class LifeScreen extends ConsumerWidget {
  const LifeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final repo = ref.watch(lifeRepositoryProvider);
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [Tab(text: l.lifeTabTimeline), Tab(text: l.lifeTabPeople), Tab(text: l.lifeTabThings)]),
          Expanded(
            child: repo.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (repo) => TabBarView(children: [
                _Timeline(repo: repo),
                _EntityList(
                  stream: repo.watchPeople(),
                  repo: repo,
                  empty: _EmptyWithAction(
                    icon: Icons.people_outline,
                    title: l.lifePeopleEmptyTitle,
                    message: l.lifePeopleEmptyBody,
                    action: l.lifeAddPerson,
                    onAction: () => showPersonSheet(context),
                  ),
                ),
                _EntityList(
                  stream: repo.watchThings(),
                  repo: repo,
                  empty: _EmptyWithAction(
                    icon: Icons.directions_car_outlined,
                    title: l.lifeThingsEmptyTitle,
                    message: l.lifeThingsEmptyBody,
                    action: l.lifeAddThing,
                    onAction: () => showThingSheet(context),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyWithAction extends StatelessWidget {
  const _EmptyWithAction({required this.icon, required this.title, required this.message, required this.action, required this.onAction});
  final IconData icon;
  final String title;
  final String message;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(children: [
          EmptyState(icon: icon, title: title, message: message),
          FilledButton.tonalIcon(onPressed: onAction, icon: const Icon(Icons.add), label: Text(action)),
        ]),
      );
}

class _EntityList extends StatelessWidget {
  const _EntityList({required this.stream, required this.repo, required this.empty});
  final Stream<List<LifeEntity>> stream;
  final LifeRepository repo;
  final Widget empty;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return StreamBuilder<List<LifeEntity>>(
      stream: stream,
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        if (snap.data!.isEmpty) return empty;
        return ListView(
          padding: const EdgeInsets.only(bottom: 96),
          children: [
            for (final e in snap.data!)
              ListTile(
                leading: CircleAvatar(
                  child: e.isPerson
                      ? Text(e.entity.displayName.characters.first.toUpperCase())
                      : Icon(thingIcon(e.entity.type), size: 20),
                ),
                title: Text(e.entity.displayName),
                subtitle: Text([
                  e.isPerson ? relationLabel(l, e.relation) : thingTypeLabel(l, e.entity.type),
                  if (_soonest(e) case final d?)
                    '${dateKindLabel(l, d.kind)} ${DateFormat.MMMd(locale).format(repo.nextOccurrence(d))}',
                ].join(' · ')),
                onTap: () => context.push('/life/${e.entity.id}'),
              ),
          ],
        );
      },
    );
  }

  /// The next upcoming date of an entity, to show in the list.
  EntityDate? _soonest(LifeEntity e) {
    final upcoming = e.dates.where((d) => !repo.nextOccurrence(d).isBefore(DateTime.now().copyWith(hour: 0, minute: 0))).toList()
      ..sort((a, b) => repo.nextOccurrence(a).compareTo(repo.nextOccurrence(b)));
    return upcoming.firstOrNull;
  }
}

class _Timeline extends StatelessWidget {
  const _Timeline({required this.repo});
  final LifeRepository repo;

  IconData _icon(TimelineKind k) => switch (k) {
        TimelineKind.event => Icons.event_outlined,
        TimelineKind.taskDue => Icons.radio_button_unchecked,
        TimelineKind.taskDone => Icons.check_circle_outline,
        TimelineKind.document => Icons.description_outlined,
        TimelineKind.memory => Icons.psychology_alt_outlined,
        TimelineKind.date => Icons.flag_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final theme = Theme.of(context);
    return StreamBuilder<List<TimelineItem>>(
      stream: repo.watchTimeline(),
      builder: (context, snap) {
        if (!snap.hasData) return const SizedBox.shrink();
        final items = snap.data!;
        if (items.isEmpty) {
          return Center(child: EmptyState(icon: Icons.timeline, title: l.lifeTimelineEmptyTitle, message: l.lifeTimelineEmptyBody));
        }
        final now = DateTime.now();
        final children = <Widget>[];
        DateTime? day;
        for (final item in items) {
          final d = DateTime(item.at.year, item.at.month, item.at.day);
          if (d != day) {
            day = d;
            children.add(Padding(
              padding: const EdgeInsets.fromLTRB(20, Gap.l, 20, Gap.xs),
              child: Text(dueLabel(l, locale, d, allDay: true, now: now),
                  style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary)),
            ));
          }
          final kind = switch (item.kind) {
            TimelineKind.event => l.tlEvent,
            TimelineKind.taskDue => l.tlTaskDue,
            TimelineKind.taskDone => l.tlTaskDone,
            TimelineKind.document => l.tlDocument,
            TimelineKind.memory => l.tlMemory,
            TimelineKind.date => dateKindLabel(l, item.detail),
          };
          children.add(ListTile(
            dense: true,
            leading: Icon(_icon(item.kind), size: 20),
            title: Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis),
            subtitle: Text(item.allDay || item.kind == TimelineKind.date ? kind : '$kind · ${DateFormat.Hm(locale).format(item.at)}'),
            onTap: item.route == null ? null : () => context.push(item.route!),
          ));
        }
        return ListView(padding: const EdgeInsets.only(bottom: 96), children: children);
      },
    );
  }
}
