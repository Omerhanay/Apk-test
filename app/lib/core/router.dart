import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/ask/ask_sheet.dart';
import '../features/documents/documents_screen.dart';
import '../features/life/life_screen.dart';
import '../features/memory/capture_sheet.dart';
import '../features/memory/memory_detail_screen.dart';
import '../features/memory/memory_screen.dart';
import '../features/settings/activity_screen.dart';
import '../features/tasks/quick_add_sheet.dart';
import '../features/settings/permissions_screen.dart';
import '../features/settings/relay_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/tasks/tasks_screen.dart';
import '../features/today/today_screen.dart';
import 'design/widgets.dart';
import '../l10n/app_localizations.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter buildRouter() => GoRouter(
      navigatorKey: _rootKey,
      initialLocation: '/today',
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, shell) => _HomeShell(shell: shell),
          branches: [
            _branch('/today', const TodayScreen()),
            _branch('/tasks', const TasksScreen()),
            _branch('/documents', const DocumentsScreen()),
            _branch('/life', const LifeScreen()),
            StatefulShellBranch(routes: [
              GoRoute(
                path: '/memory',
                builder: (context, state) => const MemoryScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    // Opens above the tab bar, like settings.
                    parentNavigatorKey: _rootKey,
                    builder: (context, state) => MemoryDetailScreen(id: state.pathParameters['id']!),
                  ),
                ],
              ),
            ]),
          ],
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
          routes: [
            GoRoute(path: 'permissions', builder: (context, state) => const PermissionsScreen()),
            GoRoute(path: 'activity', builder: (context, state) => const ActivityScreen()),
            GoRoute(path: 'relay', builder: (context, state) => const RelayScreen()),
          ],
        ),
      ],
    );

StatefulShellBranch _branch(String path, Widget screen) =>
    StatefulShellBranch(routes: [GoRoute(path: path, builder: (context, state) => screen)]);

class _HomeShell extends StatelessWidget {
  const _HomeShell({required this.shell});
  final StatefulNavigationShell shell;

  static const _todayTab = 0;
  static const _tasksTab = 1;
  static const _memoryTab = 4;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final destinations = [
      NavigationDestination(icon: const Icon(Icons.wb_sunny_outlined), selectedIcon: const Icon(Icons.wb_sunny), label: l.navToday),
      NavigationDestination(icon: const Icon(Icons.check_circle_outline), selectedIcon: const Icon(Icons.check_circle), label: l.navTasks),
      NavigationDestination(icon: const Icon(Icons.description_outlined), selectedIcon: const Icon(Icons.description), label: l.navDocuments),
      NavigationDestination(icon: const Icon(Icons.timeline_outlined), selectedIcon: const Icon(Icons.timeline), label: l.navLife),
      NavigationDestination(
          icon: const Icon(Icons.psychology_alt_outlined), selectedIcon: const Icon(Icons.psychology_alt), label: l.navMemory),
    ];

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: AskBar(onTap: () => showAskSheet(context))),
                IconButton(
                  tooltip: l.settingsTooltip,
                  icon: const Icon(Icons.account_circle_outlined),
                  onPressed: () => context.push('/settings'),
                ),
                const SizedBox(width: 8),
              ],
            ),
            // Each route in the tab navigator paints a ModalBarrier wrapped in
            // BlockSemantics, which hides earlier-painted siblings from screen
            // readers. A separate container keeps the Ask bar reachable.
            Expanded(child: Semantics(container: true, explicitChildNodes: true, child: shell)),
          ],
        ),
      ),
      floatingActionButton: switch (shell.currentIndex) {
        _todayTab || _tasksTab => FloatingActionButton(
            tooltip: l.tasksAdd,
            onPressed: () => showQuickAddSheet(context),
            child: const Icon(Icons.add),
          ),
        _memoryTab => FloatingActionButton(
            tooltip: l.memoryAdd,
            onPressed: () => showCaptureSheet(context),
            child: const Icon(Icons.add),
          ),
        _ => null,
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        destinations: destinations,
        onDestinationSelected: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
      ),
    );
  }
}
