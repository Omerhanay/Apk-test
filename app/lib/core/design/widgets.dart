import 'package:flutter/material.dart';

import 'theme.dart';
import '../../l10n/app_localizations.dart';

/// Quiet placeholder for a section with no data yet. Explains what will appear
/// and how, instead of showing fake content.
class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.message});

  final IconData icon;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Gap.xl, vertical: Gap.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: theme.colorScheme.outline),
          const SizedBox(height: Gap.m),
          Text(title, style: theme.textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: Gap.s),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader(this.label, {super.key});
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, Gap.l, 20, Gap.s),
      child: Semantics(
        header: true,
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, letterSpacing: 0.4),
        ),
      ),
    );
  }
}

/// Persistent entry point for search and Ask My Life, shown on every tab.
class AskBar extends StatelessWidget {
  const AskBar({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = AppLocalizations.of(context).askBarLabel;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, Gap.s, 16, Gap.s),
      child: Semantics(
        container: true,
        button: true,
        label: label,
        onTap: onTap,
        excludeSemantics: true,
        child: Material(
          color: scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: onTap,
            child: SizedBox(
              height: 52,
              child: Row(
                children: [
                  const SizedBox(width: Gap.m),
                  Icon(Icons.search, color: scheme.onSurfaceVariant),
                  const SizedBox(width: Gap.m),
                  Expanded(
                    child: Text(label,
                        style: TextStyle(color: scheme.onSurfaceVariant), overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
