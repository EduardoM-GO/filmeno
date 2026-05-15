import 'package:filmeno/features/movie_search/presentation/widgets/movie_search_anchor.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'trending_notifier.dart';
import 'widgets/movie_card.dart';

class TrendingPage extends HookConsumerWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmeno'),
        centerTitle: true,
        actions: [
          const MovieSearchAnchor(),
        ],
      ),
      body: trendingAsync.when(
        data: (movies) => GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return MovieCard(movie: movies[index]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Falha: $err')),
      ),
    );
  }
}
