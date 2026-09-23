import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/documents/document_repository.dart';
import '../../core/documents/field_extractor.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

IconData documentIcon(String? type) => switch (type) {
      'insurance' => Icons.shield_outlined,
      'vehicle_registration' => Icons.directions_car_outlined,
      'passport' || 'id_card' || 'driver_license' => Icons.badge_outlined,
      'warranty' => Icons.verified_outlined,
      'invoice' || 'receipt' => Icons.receipt_long_outlined,
      'contract' => Icons.handshake_outlined,
      'travel' => Icons.flight_outlined,
      'medical' => Icons.medical_information_outlined,
      _ => Icons.description_outlined,
    };

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final repo = ref.watch(documentRepositoryProvider);
    return repo.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('$e')),
      data: (repo) => StreamBuilder<List<Document>>(
        stream: repo.watchAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          final docs = snapshot.data!;
          if (docs.isEmpty) {
            return Center(
              child: EmptyState(icon: Icons.description_outlined, title: l.documentsEmptyTitle, message: l.documentsEmptyBody),
            );
          }
          return ListView(
            padding: const EdgeInsets.only(bottom: 96),
            children: [for (final d in docs) _DocumentTile(doc: d, repo: repo)],
          );
        },
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({required this.doc, required this.repo});
  final Document doc;
  final DocumentRepository repo;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final needsReview = doc.extractionStatus == 'needs_review';
    return FutureBuilder<List<DocumentExtraction>>(
      future: repo.extractions(doc.id),
      builder: (context, snap) {
        final expiry = snap.data
            ?.where((e) => e.field == 'expires_on' && (e.reviewStatus == ReviewStatus.accepted || e.reviewStatus == ReviewStatus.edited))
            .firstOrNull;
        final expiryDate = expiry == null ? null : DateTime.tryParse(expiry.value);
        return ListTile(
          leading: Icon(documentIcon(doc.docType)),
          title: Text(doc.title ?? doc.fileName),
          subtitle: Text([
            documentTypeLabel(l, doc.docType),
            if (needsReview) l.docNeedsReview,
            if (expiryDate != null) l.docExpires(DateFormat.yMMMd(locale).format(expiryDate)),
          ].join(' · '), style: needsReview ? TextStyle(color: theme.colorScheme.primary) : null),
          onTap: () => context.push(needsReview ? '/documents/${doc.id}/review' : '/documents/${doc.id}'),
        );
      },
    );
  }
}

class DocumentDetailScreen extends ConsumerWidget {
  const DocumentDetailScreen({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final repo = ref.watch(documentRepositoryProvider).value;
    if (repo == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final muted = theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return StreamBuilder<Document?>(
      stream: repo.watchById(id),
      builder: (context, docSnap) {
        final doc = docSnap.data;
        if (doc == null) return Scaffold(appBar: AppBar());
        return Scaffold(
          appBar: AppBar(title: Text(documentTypeLabel(l, doc.docType))),
          body: ListView(
            padding: const EdgeInsets.only(bottom: Gap.xl),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, Gap.s, 20, 0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(doc.title ?? doc.fileName, style: theme.textTheme.titleLarge),
                  const SizedBox(height: Gap.xs),
                  Text(DateFormat.yMMMd(locale).format(doc.createdAt), style: muted),
                ]),
              ),
              if (doc.mimeType.startsWith('image/'))
                FutureBuilder<Uint8List>(
                  future: repo.fileBytes(doc),
                  builder: (context, snap) => snap.hasData
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
                          child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.memory(snap.data!, fit: BoxFit.contain)),
                        )
                      : const SizedBox.shrink(),
                ),
              SectionHeader(l.docFields),
              FutureBuilder<List<DocumentExtraction>>(
                future: repo.extractions(doc.id),
                builder: (context, snap) {
                  final kept = (snap.data ?? const <DocumentExtraction>[])
                      .where((e) => e.reviewStatus == ReviewStatus.accepted || e.reviewStatus == ReviewStatus.edited);
                  return Column(children: [
                    for (final e in kept)
                      ListTile(
                        title: Text(documentFieldLabel(l, e.field)),
                        subtitle: Text(dateFieldKeys.contains(e.field) && DateTime.tryParse(e.value) != null
                            ? DateFormat.yMMMd(locale).format(DateTime.parse(e.value))
                            : e.value),
                      ),
                  ]);
                },
              ),
              FutureBuilder<List<String>>(
                future: repo.pages(doc.id),
                builder: (context, snap) {
                  final text = (snap.data ?? const <String>[]).join('\n\n').trim();
                  if (text.isEmpty) return const SizedBox.shrink();
                  return ExpansionTile(
                    title: Text(l.docText, style: theme.textTheme.labelLarge),
                    children: [Padding(padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.m), child: SelectableText(text))],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, Gap.m, 12, 0),
                child: Wrap(spacing: Gap.s, children: [
                  TextButton.icon(
                    onPressed: () => context.push('/documents/${doc.id}/review'),
                    icon: const Icon(Icons.fact_check_outlined),
                    label: Text(l.docReviewTitle),
                  ),
                  TextButton.icon(
                    onPressed: () => _delete(context, repo, doc),
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l.docDelete),
                  ),
                ]),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _delete(BuildContext context, DocumentRepository repo, Document doc) async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.docDeleteConfirmTitle),
        content: Text(l.docDeleteConfirmBody),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.memoryCancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.memoryDelete)),
        ],
      ),
    );
    if (ok != true || !context.mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.of(context).pop();
    await repo.delete(doc.id);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.docDeleted)));
  }
}
