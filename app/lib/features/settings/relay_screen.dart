import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ai/relay_client.dart';
import '../../core/design/theme.dart';
import '../../core/providers.dart';
import '../../core/security/key_store.dart';
import '../../l10n/app_localizations.dart';

/// Pairs the app with the user's relay. Credentials are saved only after an
/// authenticated test succeeds.
class RelayScreen extends ConsumerStatefulWidget {
  const RelayScreen({super.key});

  @override
  ConsumerState<RelayScreen> createState() => _RelayScreenState();
}

class _RelayScreenState extends ConsumerState<RelayScreen> {
  final _url = TextEditingController();
  final _token = TextEditingController();
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _url.dispose();
    _token.dispose();
    super.dispose();
  }

  Future<void> _testAndSave() async {
    final l = AppLocalizations.of(context);
    final url = _url.text.trim();
    final token = _token.text.trim();

    final problem = RelayCredentials.validate(url, token);
    if (problem != null) {
      setState(() => _error = switch (problem) {
            RelayCredentialProblem.notHttps => l.relayErrorHttps,
            RelayCredentialProblem.tokenTooShort => l.relayErrorToken,
          });
      return;
    }

    setState(() {
      _busy = true;
      _error = null;
    });
    final creds = RelayCredentials(Uri.parse(url), token);
    try {
      await ref.read(relayClientFactoryProvider)(creds).ping();
      await ref.read(keyStoreProvider).saveRelayCredentials(creds);
      final db = await ref.read(databaseProvider.future);
      await db.audit(actor: 'user', action: 'relay_paired', outcome: 'ok');
      ref.invalidate(relayCredentialsProvider);
      _token.clear();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.relaySaved)));
    } on RelayException catch (e) {
      setState(() => _error = switch (e.code) {
            'unauthorized' => l.relayErrorUnauthorized,
            'offline' => l.relayErrorOffline,
            final code => l.relayErrorOther(code),
          });
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _disconnect() async {
    await ref.read(keyStoreProvider).clearRelayCredentials();
    final db = await ref.read(databaseProvider.future);
    await db.audit(actor: 'user', action: 'relay_removed', outcome: 'ok');
    ref.invalidate(relayCredentialsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final current = ref.watch(relayCredentialsProvider).value;

    return Scaffold(
      appBar: AppBar(title: Text(l.settingsRelay)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l.relayExplain, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          const SizedBox(height: Gap.l),
          if (current != null) ...[
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.check_circle, color: theme.colorScheme.primary),
              title: Text(l.relayConnected),
              subtitle: Text(current.baseUrl.host),
              trailing: TextButton(onPressed: _disconnect, child: Text(l.relayRemove)),
            ),
            const SizedBox(height: Gap.m),
          ],
          TextField(
            controller: _url,
            keyboardType: TextInputType.url,
            autocorrect: false,
            decoration: InputDecoration(labelText: l.relayUrl, hintText: 'https://'),
          ),
          const SizedBox(height: Gap.m),
          TextField(
            controller: _token,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: InputDecoration(labelText: l.relayToken),
          ),
          if (_error != null) ...[
            const SizedBox(height: Gap.m),
            Text(_error!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
          ],
          const SizedBox(height: Gap.l),
          FilledButton(
            onPressed: _busy ? null : _testAndSave,
            style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            child: _busy
                ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
                : Text(l.relayTestAndSave),
          ),
        ],
      ),
    );
  }
}
