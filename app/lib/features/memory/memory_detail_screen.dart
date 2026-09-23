import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/memory/memory_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

/// One memory: what it says, where it came from, how it changed, and controls
/// to edit, retract or delete it.
class MemoryDetailScreen extends ConsumerWidget {
  const MemoryDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(memoryRepositoryProvider).value;
    if (repo == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    return StreamBuilder<Memory?>(
      stream: repo.watchById(id),
      builder: (context, snapshot) {
        final m = snapshot.data;
        if (m == null) return Scaffold(appBar: AppBar());
        return _Detail(memory: m, repo: repo, key: ValueKey(m.version));
      },
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({super.key, required this.memory, required this.repo});
  final Memory memory;
  final MemoryRepository repo;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat.yMMMd(locale);
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final now = DateTime.now();
    final ended = memory.validTo != null && !memory.validTo!.isAfter(now);
    final active = !ended && memory.supersededBy == null;

    return Scaffold(
      appBar: AppBar(title: Text(memoryCategoryLabel(l, memory.category))),
      body: ListView(
        padding: const EdgeInsets.only(bottom: Gap.xl),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(memory.content, style: theme.textTheme.headlineSmall),
                const SizedBox(height: Gap.m),
                Text(memorySourceLabel(l, memory.source), style: muted),
                Text(l.memoryRecordedOn(date.format(memory.createdAt)), style: muted),
                if (memory.validTo != null)
                  Text(ended ? l.memoryEndedOn(date.format(memory.validTo!)) : l.memoryValidUntil(date.format(memory.validTo!)),
                      style: muted),
                if (memory.sensitivity.index >= Sensitivity.sensitive.index)
                  Padding(
                    padding: const EdgeInsets.only(top: Gap.s),
                    child: Row(children: [
                      const Icon(Icons.lock_outline, size: 16),
                      const SizedBox(width: Gap.s),
                      Expanded(child: Text(l.memorySpecialCategoryNote, style: muted)),
                    ]),
                  ),
              ],
            ),
          ),
          if (active)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, Gap.m, 12, 0),
              child: Wrap(
                spacing: Gap.s,
                children: [
                  if (memory.userEditable)
                    TextButton.icon(onPressed: () => _edit(context), icon: const Icon(Icons.edit_outlined), label: Text(l.memoryEdit)),
                  TextButton.icon(
                    onPressed: () => _retract(context),
                    icon: const Icon(Icons.remove_circle_outline),
                    label: Text(l.memoryNoLongerTrue),
                  ),
                  TextButton.icon(onPressed: () => _delete(context), icon: const Icon(Icons.delete_outline), label: Text(l.memoryDelete)),
                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.fromLTRB(12, Gap.m, 12, 0),
              child: TextButton.icon(onPressed: () => _delete(context), icon: const Icon(Icons.delete_outline), label: Text(l.memoryDelete)),
            ),
          SectionHeader(l.memoryHistory),
          FutureBuilder<List<MemoryHistoryEntry>>(
            future: repo.history(memory.id),
            builder: (context, snapshot) {
              final entries = snapshot.data ?? const <MemoryHistoryEntry>[];
              if (snapshot.hasData && entries.isEmpty) {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(l.memoryHistoryEmpty, style: muted));
              }
              return Column(children: [
                for (final e in entries)
                  ListTile(
                    title: Text(e.content),
                    subtitle: Text('${switch (e.reason) {
                      'superseded' => l.memoryHistoryReplaced,
                      'retracted' => l.memoryHistoryRetracted,
                      _ => l.memoryHistoryEdited,
                    }} · ${date.format(e.at)}'),
                  ),
              ]);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _edit(BuildContext context) async {
    final updated = await showDialog<String>(context: context, builder: (_) => _EditDialog(initial: memory.content));
    if (updated == null || updated.trim().isEmpty || updated.trim() == memory.content) return;
    await repo.edit(memory.id, content: updated);
  }

  Future<void> _retract(BuildContext context) async {
    final l = AppLocalizations.of(context);
    await repo.retract(id: memory.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l.memoryMarkedNotTrue)));
    }
  }

  Future<void> _delete(BuildContext context) async {
    final l = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.memoryDeleteConfirmTitle),
        content: Text(l.memoryDeleteConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.memoryCancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.memoryDelete)),
        ],
      ),
    );
    if (confirmed != true) return;
    if (!context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    // Leave first: the screen's stream would otherwise rebuild on a deleted row.
    navigator.pop();
    await repo.delete(memory.id);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.memoryDeleted)));
  }
}

/// Owns its controller so it outlives the dialog's closing animation.
class _EditDialog extends StatefulWidget {
  const _EditDialog({required this.initial});
  final String initial;

  @override
  State<_EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<_EditDialog> {
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l.memoryEdit),
      content: TextField(controller: _controller, autofocus: true, minLines: 1, maxLines: 5),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l.memoryCancel)),
        FilledButton(onPressed: () => Navigator.pop(context, _controller.text), child: Text(l.memorySave)),
      ],
    );
  }
}
