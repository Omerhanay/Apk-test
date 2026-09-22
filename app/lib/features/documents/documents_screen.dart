import 'package:flutter/material.dart';

import '../../core/design/widgets.dart';
import '../../l10n/app_localizations.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: EmptyState(icon: Icons.description_outlined, title: l.documentsEmptyTitle, message: l.documentsEmptyBody),
    );
  }
}
