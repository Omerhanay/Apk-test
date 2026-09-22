import 'package:drift/drift.dart' show OrderingTerm, OrderingMode;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/database.dart';
import '../../core/design/widgets.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import 'labels.dart';

/// The audit trail: what happened, when and with what outcome. It never holds
/// personal content, only action codes and ids.
class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final db = ref.watch(databaseProvider);
    final format = DateFormat.yMMMd(Localizations.localeOf(context).toLanguageTag()).add_Hm();

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsActivity)),
      body: db.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (db) => StreamBuilder<List<AuditEntry>>(
          stream: (db.select(db.auditLogs)
                ..orderBy([(a) => OrderingTerm(expression: a.id, mode: OrderingMode.desc)])
                ..limit(200))
              .watch(),
          builder: (context, snapshot) {
            final entries = snapshot.data ?? const <AuditEntry>[];
            if (snapshot.hasData && entries.isEmpty) {
              return Center(
                child: EmptyState(icon: Icons.history, title: l.activityEmptyTitle, message: l.activityEmptyBody),
              );
            }
            return ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final e = entries[i];
                final target = e.targetType == 'capability' && e.targetId != null ? capabilityLabel(l, e.targetId!) : null;
                return ListTile(
                  leading: Icon(e.outcome == 'ok' ? Icons.check_circle_outline : Icons.block, size: 20),
                  title: Text(auditActionLabel(l, e.action)),
                  subtitle: Text([?target, format.format(e.at)].join(' · ')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
