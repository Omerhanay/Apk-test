import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/ai/relay_client.dart';
import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/design/widgets.dart';
import '../../core/documents/classifier.dart';
import '../../core/documents/document_repository.dart';
import '../../core/documents/field_extractor.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

/// Shows what was read from a document. Nothing is saved as a date or
/// reminder until the user taps Save; unticked items are discarded.
class DocumentReviewScreen extends ConsumerStatefulWidget {
  const DocumentReviewScreen({super.key, required this.id});
  final String id;

  @override
  ConsumerState<DocumentReviewScreen> createState() => _DocumentReviewScreenState();
}

class _DocumentReviewScreenState extends ConsumerState<DocumentReviewScreen> {
  final _keep = <String, bool>{};
  final _edited = <String, String>{};
  int? _leadDays;
  bool _aiBusy = false;
  String? _aiMessage;
  bool _saving = false;

  static const _leadOptions = [7, 14, 30, 60, 90, 180];

  Future<void> _findWithAi(DocumentRepository repo, Document doc) async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final creds = await ref.read(relayCredentialsProvider.future);
    if (creds == null) return;
    setState(() {
      _aiBusy = true;
      _aiMessage = null;
    });
    try {
      final result = await ref.read(relayClientFactoryProvider)(creds).extractDocument(
            text: (await repo.pages(doc.id)).join('\n'),
            docType: doc.docType ?? 'other',
            locale: locale,
            today: ref.read(clockProvider)(),
          );
      final kept = await repo.addAiSuggestions(
        doc.id,
        title: result.title,
        suggestions: [
          for (final f in result.fields)
            ExtractedField(key: f.key, value: f.value, quote: f.quote, confidence: f.confidence, origin: 'ai'),
        ],
      );
      if (mounted) setState(() => _aiMessage = l.docAiFound(kept));
    } on RelayException {
      if (mounted) setState(() => _aiMessage = l.docAiFailed);
    } finally {
      if (mounted) setState(() => _aiBusy = false);
    }
  }

  Future<void> _edit(DocumentExtraction e) async {
    final l = AppLocalizations.of(context);
    final current = _edited[e.id] ?? e.value;
    String? value;
    if (dateFieldKeys.contains(e.field)) {
      final initial = DateTime.tryParse(current) ?? ref.read(clockProvider)();
      final picked = await showDatePicker(
        context: context,
        initialDate: initial,
        firstDate: DateTime(1990),
        lastDate: DateTime(2100),
      );
      if (picked != null) {
        value = '${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      }
    } else {
      value = await showDialog<String>(context: context, builder: (_) => _TextEditDialog(title: l.docEditValue, initial: current));
    }
    if (value != null && value.trim().isNotEmpty) setState(() => _edited[e.id] = value!.trim());
  }

  Future<void> _save(DocumentRepository repo, Document doc, List<DocumentExtraction> fields) async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    setState(() => _saving = true);
    for (final e in fields) {
      final keep = _keep[e.id] ?? true;
      await repo.setFieldStatus(e.id, keep ? ReviewStatus.accepted : ReviewStatus.rejected, value: keep ? _edited[e.id] : null);
    }
    final name = doc.title ?? documentTypeLabel(l, doc.docType);
    final expiry = fields.where((e) => e.field == 'expires_on' && (_keep[e.id] ?? true)).firstOrNull;
    final expiryText = expiry == null
        ? ''
        : DateFormat.yMMMd(locale).format(DateTime.parse(_edited[expiry.id] ?? expiry.value));
    final confirmed = await repo.confirmReview(
      doc.id,
      reminderTitle: l.docReminderTitle(name, expiryText),
      leadDays: _leadDays,
    );
    final reminder = confirmed.map((c) => c.reminderAt).whereType<DateTime>().firstOrNull;
    if (reminder != null) {
      final notifications = await ref.read(notificationSchedulerProvider.future);
      await notifications.requestPermission();
    }
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(reminder == null ? l.docSaved : l.docSavedWithReminder(DateFormat.yMMMd(locale).format(reminder))),
      ));
    router.pushReplacement('/documents/${doc.id}');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final repo = ref.watch(documentRepositoryProvider).value;
    final relayConfigured = ref.watch(relayCredentialsProvider).value != null;
    if (repo == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    return StreamBuilder<Document?>(
      stream: repo.watchById(widget.id),
      builder: (context, docSnap) {
        final doc = docSnap.data;
        if (doc == null) return Scaffold(appBar: AppBar());
        return StreamBuilder<List<DocumentExtraction>>(
          stream: repo.watchExtractions(doc.id),
          builder: (context, snap) {
            final fields = snap.data ?? const <DocumentExtraction>[];
            final hasReminderDate = fields.any((e) => (e.field == 'expires_on' || e.field == 'renews_on') && (_keep[e.id] ?? true));
            final lead = _leadDays ?? reminderLeadDays[doc.docType] ?? 14;
            return Scaffold(
              appBar: AppBar(title: Text(l.docReviewTitle)),
              body: ListView(
                padding: const EdgeInsets.only(bottom: Gap.xl),
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, Gap.s, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doc.title ?? doc.fileName, style: theme.textTheme.titleLarge),
                        const SizedBox(height: Gap.s),
                        Text(l.docReviewIntro, style: muted),
                        const SizedBox(height: Gap.m),
                        DropdownButtonFormField<String>(
                          initialValue: doc.docType ?? 'other',
                          decoration: InputDecoration(labelText: l.docType),
                          items: [
                            for (final t in documentTypes) DropdownMenuItem(value: t, child: Text(documentTypeLabel(l, t))),
                          ],
                          onChanged: (t) => t == null ? null : repo.setType(doc.id, t),
                        ),
                      ],
                    ),
                  ),
                  if (doc.ocrStatus == 'failed')
                    Padding(padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0), child: Text(l.docOcrFailed)),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
                    child: DocumentRepository.mayUseAi(doc)
                        ? (relayConfigured && doc.ocrStatus != 'failed'
                            ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                OutlinedButton.icon(
                                  onPressed: _aiBusy ? null : () => _findWithAi(repo, doc),
                                  icon: _aiBusy
                                      ? const SizedBox.square(dimension: 16, child: CircularProgressIndicator(strokeWidth: 2))
                                      : const Icon(Icons.auto_awesome_outlined),
                                  label: Text(l.docFindWithAi),
                                ),
                                const SizedBox(height: Gap.xs),
                                Text(l.docAiNote, style: muted),
                                if (_aiMessage != null) ...[const SizedBox(height: Gap.s), Text(_aiMessage!)],
                              ])
                            : const SizedBox.shrink())
                        : Row(children: [
                            const Icon(Icons.lock_outline, size: 16),
                            const SizedBox(width: Gap.s),
                            Expanded(child: Text(l.docLocalOnlyNote, style: muted)),
                          ]),
                  ),
                  SectionHeader(l.docFields),
                  if (snap.hasData && fields.isEmpty)
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20), child: Text(l.docNoFields, style: muted)),
                  for (final e in fields)
                    CheckboxListTile(
                      value: _keep[e.id] ?? true,
                      onChanged: (v) => setState(() => _keep[e.id] = v ?? false),
                      title: Text(documentFieldLabel(l, e.field)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_display(_edited[e.id] ?? e.value, e.field, locale), style: theme.textTheme.bodyLarge),
                          if (e.quote != null) Text('“${e.quote}”', style: muted?.copyWith(fontStyle: FontStyle.italic)),
                          Text(e.origin == 'ai' ? l.memorySourceAi : l.docSourceLocal, style: muted),
                        ],
                      ),
                      secondary: IconButton(
                        tooltip: l.docEditValue,
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () => _edit(e),
                      ),
                      isThreeLine: true,
                    ),
                  if (hasReminderDate)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, Gap.m, 20, 0),
                      child: DropdownButtonFormField<int>(
                        initialValue: _leadOptions.contains(lead) ? lead : 30,
                        items: [for (final d in _leadOptions) DropdownMenuItem(value: d, child: Text(l.docRemindBefore(d)))],
                        onChanged: (d) => setState(() => _leadDays = d),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, Gap.l, 20, 0),
                    child: FilledButton(
                      onPressed: _saving ? null : () => _save(repo, doc, fields),
                      style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
                      child: Text(l.taskSave),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static String _display(String value, String field, String locale) {
    if (!dateFieldKeys.contains(field)) return value;
    final date = DateTime.tryParse(value);
    return date == null ? value : DateFormat.yMMMd(locale).format(date);
  }
}

class _TextEditDialog extends StatefulWidget {
  const _TextEditDialog({required this.title, required this.initial});
  final String title;
  final String initial;

  @override
  State<_TextEditDialog> createState() => _TextEditDialogState();
}

class _TextEditDialogState extends State<_TextEditDialog> {
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
      title: Text(widget.title),
      content: TextField(controller: _controller, autofocus: true),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text(l.memoryCancel)),
        FilledButton(onPressed: () => Navigator.pop(context, _controller.text), child: Text(l.taskSave)),
      ],
    );
  }
}
