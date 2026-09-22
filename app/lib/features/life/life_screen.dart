import 'package:flutter/material.dart';

import '../../core/design/widgets.dart';
import '../../l10n/app_localizations.dart';

class LifeScreen extends StatelessWidget {
  const LifeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(tabs: [Tab(text: l.lifeTabTimeline), Tab(text: l.lifeTabPeople), Tab(text: l.lifeTabThings)]),
          Expanded(
            child: TabBarView(
              children: [
                EmptyState(icon: Icons.timeline, title: l.lifeTimelineEmptyTitle, message: l.lifeTimelineEmptyBody),
                EmptyState(icon: Icons.people_outline, title: l.lifePeopleEmptyTitle, message: l.lifePeopleEmptyBody),
                EmptyState(icon: Icons.directions_car_outlined, title: l.lifeThingsEmptyTitle, message: l.lifeThingsEmptyBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
