import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/permissions/permission_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import 'labels.dart';

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final repo = ref.watch(permissionRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsPermissions)),
      body: repo.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (repo) => StreamBuilder<List<PermissionGrantRow>>(
          stream: repo.watch(),
          builder: (context, snapshot) {
            final rows = {for (final r in snapshot.data ?? const <PermissionGrantRow>[]) r.capability: r};
            final caps = repo.capabilities;
            final reads = caps.where((c) => !c.isAction);
            final actions = caps.where((c) => c.isAction);

            return ListView(
              padding: const EdgeInsets.only(bottom: Gap.xl),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
                  child: Text(l.permissionsExplain,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          )),
                ),
                SectionHeader(l.permissionsRead),
                for (final c in reads) _CapabilityTile(info: c, row: rows[c.capability], repo: repo),
                SectionHeader(l.permissionsAct),
                for (final c in actions) _CapabilityTile(info: c, row: rows[c.capability], repo: repo),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CapabilityTile extends StatelessWidget {
  const _CapabilityTile({required this.info, required this.row, required this.repo});

  final CapabilityInfo info;
  final PermissionGrantRow? row;
  final PermissionRepository repo;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final granted = row?.granted ?? false;
    final askFirst = !(row?.autonomous ?? false);

    return Column(
      children: [
        SwitchListTile(
          title: Text(capabilityLabel(l, info.capability)),
          value: granted,
          onChanged: row == null ? null : (v) => repo.setGranted(info.capability, v),
        ),
        if (info.isAction && granted)
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CheckboxListTile(
              dense: true,
              title: Text(l.permissionAskFirst),
              value: askFirst,
              // High-risk actions always ask; the control is shown but locked.
              onChanged: info.autonomyAllowed ? (v) => repo.setAskFirst(info.capability, v ?? true) : null,
            ),
          ),
      ],
    );
  }
}
