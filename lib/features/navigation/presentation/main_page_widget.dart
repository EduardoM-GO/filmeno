import 'package:filmeno/features/movie_recommendations/presentation/pages/recommendations_page_widget.dart';
import 'package:filmeno/features/user_profile/presentation/profile_watchlist_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../movie_trending/presentation/trending_page_widget.dart';

class MainPageWidget extends HookConsumerWidget {
  const MainPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);
    final width = MediaQuery.sizeOf(context).width;
    final isWideScreen = width > 720;

    final destinations = const [
      _MainDestination(
        label: 'Em alta',
        icon: Icons.local_fire_department_outlined,
        selectedIcon: Icons.local_fire_department,
        page: TrendingPageWidget(),
      ),
      _MainDestination(
        label: 'Indicações',
        icon: Icons.auto_awesome_outlined,
        selectedIcon: Icons.auto_awesome,
        page: RecommendationsPageWidget(),
      ),
      _MainDestination(
        label: 'Biblioteca',
        icon: Icons.bookmark_border,
        selectedIcon: Icons.bookmark,
        page: ProfileWatchlistPageWidget(),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: selectedIndex.value,
              onDestinationSelected: (i) => selectedIndex.value = i,
              extended: width > 960,
              minExtendedWidth: 188,
              minWidth: 76,
              groupAlignment: -0.82,
              labelType: NavigationRailLabelType.all,
              destinations: destinations
                  .map(
                    (destination) => NavigationRailDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: Text(destination.label),
                    ),
                  )
                  .toList(),
            ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex.value,
              children:
                  destinations.map((destination) => destination.page).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex.value,
              onDestinationSelected: (i) => selectedIndex.value = i,
              destinations: destinations
                  .map(
                    (destination) => NavigationDestination(
                      icon: Icon(destination.icon),
                      selectedIcon: Icon(destination.selectedIcon),
                      label: destination.label,
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

final class _MainDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const _MainDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
