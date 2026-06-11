import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/features/movie_recommendations/presentation/movie_recommendations_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../movie_search/presentation/widgets/movie_search_anchor.dart';
import '../../../movie_trending/presentation/widgets/movie_card.dart';

final class RecommendationsPage extends ConsumerWidget {
  const RecommendationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync = ref.watch(movieRecommendationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Indicações para Você'),
        centerTitle: true,
        actions: [
          const MovieSearchAnchor(),
        ],
      ),
      body: recommendationsAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const CinemaEmptyWidget(
              icon: Icons.psychology_outlined,
              title: 'Calibrando o Projetor...',
              message:
                  'Curta ou favorite seus filmes prediletos na tela de detalhes para que o nosso assistente monte uma sessão exclusiva para você!',
            );
          }

          return GridView.builder(
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
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, __) => Center(child: Text('Erro ao computar indicações: $err')),
      ),
    );
  }
}
