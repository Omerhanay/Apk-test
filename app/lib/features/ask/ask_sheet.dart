import 'package:flutter/material.dart';

import '../../core/design/theme.dart';
import '../../l10n/app_localizations.dart';

Future<void> showAskSheet(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => const AskSheet(),
    );

/// Ask My Life. The agent loop is connected in the retrieval phase; until then
/// this sheet says so plainly instead of simulating answers.
class AskSheet extends StatelessWidget {
  const AskSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              autofocus: true,
              enabled: false,
              decoration: InputDecoration(hintText: l.askHint, prefixIcon: const Icon(Icons.search)),
            ),
            const SizedBox(height: Gap.m),
            Text(
              l.askNotConnected,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
