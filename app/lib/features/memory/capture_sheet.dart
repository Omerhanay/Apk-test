import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/ai/relay_client.dart';
import '../../core/db/database.dart';
import '../../core/design/theme.dart';
import '../../core/memory/memory_repository.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import '../settings/labels.dart';

Future<void> showCaptureSheet(BuildContext context) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => const CaptureSheet(),
    );

enum _Stage { input, working, preview, retract, manual }

/// Turns a sentence into a memory. With a relay, the AI proposes a structure
/// the user reviews; without one (or if it fails) the user files it by hand.
/// Nothing is stored until the user taps Save.
class CaptureSheet extends ConsumerStatefulWidget {
  const CaptureSheet({super.key});

  @override
  ConsumerState<CaptureSheet> createState() => _CaptureSheetState();
}

class _CaptureSheetState extends ConsumerState<CaptureSheet> {
  final _text = TextEditingController();
  final _content = TextEditingController();
  _Stage _stage = _Stage.input;
  bool? _useAi;
  String _category = 'other';
  String? _message;
  MemoryParseResult? _parse;
  List<Memory> _affected = const [];

  @override
  void dispose() {
    _text.dispose();
    _content.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    final l = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final text = _text.text.trim();
    if (text.isEmpty) return;
    final creds = await ref.read(relayCredentialsProvider.future);
    final repo = await ref.read(memoryRepositoryProvider.future);

    if (!(_useAi ?? creds != null) || creds == null) {
      _toManual(text);
      return;
    }

    setState(() {
      _stage = _Stage.working;
      _message = null;
    });
    try {
      final parse = await ref.read(relayClientFactoryProvider)(creds).parseMemory(
            text: text,
            locale: locale,
            today: ref.read(clockProvider)(),
            knownSubjects: await repo.knownSubjects(),
          );
      if (!mounted) return;
      if (parse.needsClarification != null) {
        setState(() {
          _stage = _Stage.input;
          _message = parse.needsClarification;
        });
        return;
      }
      final keyed = parse.subject != null && parse.predicate != null;
      final matches = keyed ? await repo.activeByKey(parse.subject!, parse.predicate!) : const <Memory>[];
      setState(() {
        _parse = parse;
        _affected = matches;
        _content.text = parse.content;
        _category = memoryCategories.contains(parse.category) ? parse.category : 'other';
        _stage = parse.op == 'retract' ? _Stage.retract : _Stage.preview;
      });
    } on RelayException {
      if (!mounted) return;
      _toManual(text, message: l.memoryAiUnavailable);
    }
  }

  void _toManual(String text, {String? message}) => setState(() {
        _content.text = text;
        _parse = null;
        _affected = const [];
        _message = message;
        _stage = _Stage.manual;
      });

  Future<void> _save() async {
    final l = AppLocalizations.of(context);
    final repo = await ref.read(memoryRepositoryProvider.future);
    final parse = _parse;
    final content = _content.text.trim();
    if (content.isEmpty) return;

    // The user confirmed this statement, so it is theirs even when the AI structured it.
    final result = await repo.remember(parse == null || _stage == _Stage.manual
        ? MemoryDraft(content: content, category: _category, sensitivity: sensitivityForCategory(_category))
        : MemoryDraft(
            content: content,
            category: _category,
            kind: MemoryKind.values.asNameMap()[parse.kind] ?? MemoryKind.semantic,
            subject: parse.subject,
            predicate: parse.predicate,
            value: parse.value,
            validUntil: parse.validUntil,
            sensitivity: _sensitivity(parse.sensitivity, _category),
            confidence: parse.confidence,
          ));
    if (!mounted) return;
    // The sheet's context is gone after pop; the messenger belongs to the page below.
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    // Replace any earlier confirmation instead of queueing behind it.
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(result.supersededIds.isEmpty ? l.memoryRemembered : l.memoryUpdatedKeepsHistory)),
      );
  }

  Future<void> _retract() async {
    final l = AppLocalizations.of(context);
    final repo = await ref.read(memoryRepositoryProvider.future);
    for (final m in _affected) {
      await repo.retract(id: m.id);
    }
    if (!mounted) return;
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    // Replace any earlier confirmation instead of queueing behind it.
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l.memoryMarkedNotTrue)));
  }

  /// The stricter of the AI's reading and the category default.
  Sensitivity _sensitivity(String fromAi, String category) {
    final ai = switch (fromAi) {
      'special_category' => Sensitivity.specialCategory,
      'sensitive' => Sensitivity.sensitive,
      'personal' => Sensitivity.personal,
      _ => Sensitivity.normal,
    };
    final byCategory = sensitivityForCategory(category);
    return ai.index >= byCategory.index ? ai : byCategory;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final relayConfigured = ref.watch(relayCredentialsProvider).value != null;
    final useAi = _useAi ?? relayConfigured;
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);

    final children = <Widget>[];
    switch (_stage) {
      case _Stage.input || _Stage.working:
        children.addAll([
          TextField(
            controller: _text,
            autofocus: true,
            minLines: 2,
            maxLines: 6,
            maxLength: 2000,
            enabled: _stage == _Stage.input,
            decoration: InputDecoration(labelText: l.memoryCaptureHint, hintText: l.memoryCaptureExample),
          ),
          if (relayConfigured)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.memoryOrganizeWithAi),
              subtitle: Text(l.memoryOrganizeNote, style: muted),
              value: useAi,
              onChanged: _stage == _Stage.input ? (v) => setState(() => _useAi = v) : null,
            ),
          _primary(_stage == _Stage.working ? null : _continue, l.memoryContinue, busy: _stage == _Stage.working),
        ]);
      case _Stage.preview || _Stage.manual:
        final replaces = _stage == _Stage.preview ? _affected : const <Memory>[];
        children.addAll([
          Text(l.memoryPreviewTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: Gap.m),
          TextField(controller: _content, minLines: 1, maxLines: 5),
          const SizedBox(height: Gap.m),
          DropdownButtonFormField<String>(
            initialValue: _category,
            decoration: InputDecoration(labelText: l.memoryCategory),
            items: [
              for (final c in memoryCategories) DropdownMenuItem(value: c, child: Text(memoryCategoryLabel(l, c))),
            ],
            onChanged: (v) => setState(() => _category = v ?? 'other'),
          ),
          for (final old in replaces) ...[
            const SizedBox(height: Gap.m),
            Text(l.memoryReplaces(old.content), style: muted),
          ],
          if (_category == 'health' || _parse?.sensitivity == 'special_category') ...[
            const SizedBox(height: Gap.m),
            Row(children: [
              const Icon(Icons.lock_outline, size: 16),
              const SizedBox(width: Gap.s),
              Expanded(child: Text(l.memorySpecialCategoryNote, style: muted)),
            ]),
          ],
          _primary(_save, l.memorySave),
        ]);
      case _Stage.retract:
        children.addAll([
          Text(l.memoryRetractPreviewTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: Gap.m),
          if (_affected.isEmpty) ...[
            Text(l.memoryRetractNoMatch),
            _primary(() => _toManual(_text.text.trim()), l.memorySaveAsNote),
          ] else ...[
            for (final m in _affected)
              ListTile(contentPadding: EdgeInsets.zero, leading: const Icon(Icons.remove_circle_outline), title: Text(m.content)),
            _primary(_retract, l.memoryNoLongerTrue),
          ],
        ]);
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, Gap.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...children,
            if (_message != null) ...[
              const SizedBox(height: Gap.m),
              Text(_message!, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.error)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _primary(VoidCallback? onPressed, String label, {bool busy = false}) => Padding(
        padding: const EdgeInsets.only(top: Gap.l),
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(48)),
          child: busy
              ? const SizedBox.square(dimension: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : Text(label),
        ),
      );
}
