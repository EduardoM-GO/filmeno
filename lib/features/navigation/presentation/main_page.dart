import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../movie_search/presentation/search_page.dart';
import '../../movie_trending/presentation/trending_page.dart';
import '../../movie_watchlist/presentation/watchlist_page.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(0);

    final isWideScreen = MediaQuery.of(context).size.width > 600;

    final pages = [
      const TrendingPage(),
      const SearchPage(),
      const WatchlistPage(),
    ];

    return Scaffold(
      body: Row(
        children: [
          if (isWideScreen)
            NavigationRail(
              selectedIndex: selectedIndex.value,
              onDestinationSelected: (i) => selectedIndex.value = i,
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.trending_up), label: Text('Trending')),
                NavigationRailDestination(icon: Icon(Icons.search), label: Text('Search')),
                NavigationRailDestination(icon: Icon(Icons.bookmark), label: Text('Watchlist')),
              ],
            ),
          Expanded(
            child: IndexedStack(
              index: selectedIndex.value,
              children: pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: isWideScreen
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex.value,
              onDestinationSelected: (i) => selectedIndex.value = i,
              destinations: const [
                NavigationDestination(icon: Icon(Icons.trending_up), label: 'Trending'),
                NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(icon: Icon(Icons.bookmark), label: 'Watchlist'),
              ],
            ),
    );
  }
}
