import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/widgets.dart';
import '../../core/locale.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final chosen = ref.watch(localeProvider);
    final relay = ref.watch(relayCredentialsProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsTitle)),
      body: ListView(
        children: [
          SectionHeader(l.settingsTrust),
          ListTile(
            leading: const Icon(Icons.shield_outlined),
            title: Text(l.settingsPermissions),
            subtitle: Text(l.settingsPermissionsSub),
            onTap: () => context.push('/settings/permissions'),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: Text(l.settingsActivity),
            subtitle: Text(l.settingsActivitySub),
            onTap: () => context.push('/settings/activity'),
          ),
          SectionHeader(l.settingsConnection),
          ListTile(
            leading: const Icon(Icons.cloud_outlined),
            title: Text(l.settingsRelay),
            subtitle: Text(relay == null ? l.settingsRelayNotConfigured : '${l.relayConnected} · ${relay.baseUrl.host}'),
            onTap: () => context.push('/settings/relay'),
          ),
          SectionHeader(l.settingsSafety),
          ListTile(
            leading: const Icon(Icons.medical_information_outlined),
            title: Text(l.settingsEmergency),
            subtitle: Text(l.settingsEmergencySub),
          ),
          SectionHeader(l.settingsPreferences),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l.settingsLanguage),
            subtitle: Text(chosen == null ? l.languageSystem : supportedLanguages[chosen.languageCode]!),
            onTap: () => _pickLanguage(context, ref, chosen),
          ),
          SectionHeader(l.settingsYourData),
          ListTile(leading: const Icon(Icons.file_download_outlined), title: Text(l.settingsExport)),
          ListTile(leading: const Icon(Icons.delete_outline), title: Text(l.settingsDelete)),
        ],
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref, Locale? current) async {
    final l = AppLocalizations.of(context);
    // Empty string stands for "follow the device"; null means the sheet was dismissed.
    final picked = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => RadioGroup<String>(
        groupValue: current?.languageCode ?? '',
        onChanged: (v) => Navigator.pop(context, v),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(value: '', title: Text(l.languageSystem)),
              for (final entry in supportedLanguages.entries)
                RadioListTile<String>(value: entry.key, title: Text(entry.value)),
            ],
          ),
        ),
      ),
    );
    if (picked == null) return;
    await ref.read(localeProvider.notifier).select(picked.isEmpty ? null : Locale(picked));
  }
}
