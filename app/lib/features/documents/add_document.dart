import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/design/theme.dart';
import '../../core/providers.dart';
import '../../l10n/app_localizations.dart';
import 'document_picker.dart';

final documentPickerProvider = Provider<DocumentPicker>((ref) => SystemDocumentPicker());

/// Choose a file or take a photo, import it, then open its review.
Future<void> showAddDocumentSheet(BuildContext context, WidgetRef ref) async {
  ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
  final l = AppLocalizations.of(context);
  final picker = ref.read(documentPickerProvider);
  final choice = await showModalBottomSheet<Future<PickedDocument?> Function()>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.folder_open_outlined),
            title: Text(l.docChooseFile),
            onTap: () => Navigator.pop(context, picker.pickFile),
          ),
          ListTile(
            leading: const Icon(Icons.photo_camera_outlined),
            title: Text(l.docTakePhoto),
            onTap: () => Navigator.pop(context, picker.takePhoto),
          ),
          const SizedBox(height: Gap.s),
        ],
      ),
    ),
  );
  if (choice == null || !context.mounted) return;
  final picked = await choice();
  if (picked == null || !context.mounted) return;
  await importAndReview(context, ref, picked);
}

Future<void> importAndReview(BuildContext context, WidgetRef ref, PickedDocument picked) async {
  final l = AppLocalizations.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final router = GoRouter.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);

  showDialog<void>(
    context: context,
    barrierDismissible: false,
    useRootNavigator: true,
    builder: (_) => PopScope(
      canPop: false,
      child: AlertDialog(
        content: Row(children: [
          const SizedBox.square(dimension: 24, child: CircularProgressIndicator(strokeWidth: 2.5)),
          const SizedBox(width: Gap.m),
          Expanded(child: Text(l.docReading)),
        ]),
      ),
    ),
  );
  try {
    final repo = await ref.read(documentRepositoryProvider.future);
    final result = await repo.import(fileName: picked.name, mimeType: picked.mimeType, bytes: picked.bytes);
    navigator.pop();
    if (result.duplicate) {
      messenger.showSnackBar(SnackBar(content: Text(l.docAlreadyAdded)));
      router.push('/documents/${result.id}');
    } else {
      router.push('/documents/${result.id}/review');
    }
  } on ArgumentError {
    navigator.pop();
    messenger.showSnackBar(SnackBar(content: Text(l.docUnsupported)));
  }
}
