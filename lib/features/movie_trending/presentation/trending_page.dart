import 'package:filmeno/features/movie_search/presentation/widgets/movie_search_anchor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'; // Importante para usar hooks
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'trending_notifier.dart';
import 'widgets/movie_card.dart';

class TrendingPage extends HookConsumerWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta o estado do Notifier paginado
    final trendingAsync = ref.watch(trendingMoviesProvider);

    // O Hook gere o ciclo de vida do ScrollController
    final scrollController = useScrollController();

    // Efeito para detetar a rolagem e disparar a próxima página
    useEffect(() {
      void scrollListener() {
        // Verifica se o utilizador chegou a 90% do fundo do ecrã para antecipar o carregamento
        if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * 0.9) {
          ref.read(trendingMoviesProvider.notifier).fetchNextPage();
        }
      }

      scrollController.addListener(scrollListener);
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmeno'),
        centerTitle: true,
        actions: [
          const MovieSearchAnchor(),
        ],
      ),
      body: trendingAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(child: Text('Nenhum filme encontrado.'));
          }

          return GridView.builder(
            controller: scrollController, // Vincula o controlador ao GridView
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            // Adiciona 2 itens extras no fim para renderizar o indicador de progresso (Loading)
            itemCount: movies.length + 2,
            itemBuilder: (context, index) {
              // Se chegámos aos itens extras do fim, renderiza um loading discreto
              if (index >= movies.length) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return MovieCard(movie: movies[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Falha: $err')),
      ),
    );
  }
}
