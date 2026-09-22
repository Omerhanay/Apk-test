import 'package:flutter/material.dart';

import '../../core/design/widgets.dart';
import '../../l10n/app_localizations.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [Tab(text: l.tasksTabToday), Tab(text: l.tasksTabUpcoming), Tab(text: l.tasksTabSomeday)]),
          Expanded(
            child: TabBarView(
              children: [
                EmptyState(icon: Icons.check_circle_outline, title: l.tasksEmptyTodayTitle, message: l.tasksEmptyTodayBody),
                EmptyState(icon: Icons.upcoming_outlined, title: l.tasksEmptyUpcomingTitle, message: l.tasksEmptyUpcomingBody),
                EmptyState(icon: Icons.inbox_outlined, title: l.tasksEmptySomedayTitle, message: l.tasksEmptySomedayBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
