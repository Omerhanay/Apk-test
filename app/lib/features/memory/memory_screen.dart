import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/memory/memory_repository.dart';
import '../../core/providers.dart';
import '../../core/text/search_fold.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

/// Everything LIFE OS currently believes, grouped by category, with its source.
class MemoryScreen extends ConsumerStatefulWidget {
  const MemoryScreen({super.key});

  @override
  ConsumerState<MemoryScreen> createState() => _MemoryScreenState();
}

class _MemoryScreenState extends ConsumerState<MemoryScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final repo = ref.watch(memoryRepositoryProvider);

    // The add button lives on the shell's Scaffold (see router.dart) so that
    // snackbars, which the outer Scaffold shows, push it up instead of covering it.
    return repo.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (repo) => StreamBuilder<List<Memory>>(
        stream: repo.watchActive(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          final all = snapshot.data!;
          if (all.isEmpty) {
            return Center(
              child: EmptyState(
                icon: Icons.psychology_alt_outlined,
                title: l.memoryEmptyTitle,
                message: l.memoryEmptyBody,
              ),
            );
          }
          final terms = searchTerms(_query);
          final shown = terms.isEmpty
              ? all
              : all.where((m) {
                  final haystack = foldForSearch(
                    '${m.content} ${memoryCategoryLabel(l, m.category)} ${m.value ?? ''}',
                  );
                  return terms.every(haystack.contains);
                }).toList();

          return ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, Gap.s, 16, 0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: l.memorySearchHint,
                    prefixIcon: const Icon(Icons.filter_list),
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              if (shown.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(Gap.xl),
                  child: Center(child: Text(l.memoryNoResults)),
                ),
              for (final category in memoryCategories)
                if (shown.any((m) => m.category == category)) ...[
                  SectionHeader(memoryCategoryLabel(l, category)),
                  for (final m in shown.where((m) => m.category == category))
                    MemoryTile(memory: m),
                ],
            ],
          );
        },
      ),
    );
  }
}

class MemoryTile extends StatelessWidget {
  const MemoryTile({super.key, required this.memory});
  final Memory memory;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final sensitive = memory.sensitivity.index >= Sensitivity.sensitive.index;
    return ListTile(
      title: Text(memory.content),
      subtitle: Text(memorySourceLabel(l, memory.source)),
      trailing: sensitive ? const Icon(Icons.lock_outline, size: 18) : null,
      onTap: () => context.push('/memory/${memory.id}'),
    );
  }
}
