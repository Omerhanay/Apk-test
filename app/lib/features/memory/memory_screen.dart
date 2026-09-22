import 'package:flutter/material.dart';

import '../../core/design/widgets.dart';
import '../../l10n/app_localizations.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: EmptyState(icon: Icons.psychology_alt_outlined, title: l.memoryEmptyTitle, message: l.memoryEmptyBody),
    );
  }
}
