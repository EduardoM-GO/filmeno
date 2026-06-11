import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_page.dart';
import 'package:filmeno/features/movie_search/presentation/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MovieSearchAnchor extends HookConsumerWidget {
  const MovieSearchAnchor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchController = useSearchController();
    final searchAsync = ref.watch(movieSearchProvider);

    useEffect(() {
      void onQueryChanged() {
        ref.read(movieSearchProvider.notifier).search(searchController.text);
      }

      searchController.addListener(onQueryChanged);
      return () => searchController.removeListener(onQueryChanged);
    }, [searchController]);

    return SearchAnchor(
      searchController: searchController,
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => controller.openView(),
        );
      },
      suggestionsBuilder: (context, controller) {
        final currentQuery = searchController.text;

        if (currentQuery.trim().length < 2) {
          return [
            CinemaEmptyWidget(
              title: 'Digite pelo menos 2 caracteres para buscar.',
              message: '',
              icon: Icons.search,
            ),
          ];
        }

        return [
          searchAsync.when(
            skipLoadingOnRefresh: false,
            data: (results) {
              if (results.isEmpty) {
                return CinemaEmptyWidget(
                  title: 'Cena não encontrada',
                  message:
                      'Parece que esse filme fugiu do nosso roteiro. Tente buscar por outro título!',
                  icon: Icons.search_off,
                );
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final movie = results[index];
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(
                      '${movie.mediaType.name} • ${movie.voteAverage.toStringAsFixed(1)} ★',
                    ),
                    leading: movie.posterPath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              width: 50,
                              height: 75,
                              fit: BoxFit.cover,
                              imageUrl: '${ApiConfig.baseImageUrl}w92${movie.posterPath}',
                              placeholder: (context, url) => Container(
                                color: colorScheme.surfaceContainerHighest,
                                child:
                                    const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: colorScheme.surfaceContainerHighest,
                                child: const Icon(Icons.movie_creation_outlined),
                              ),
                            ),
                          )
                        : Container(
                            width: 50,
                            height: 75,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.image_not_supported_outlined),
                          ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(movieId: movie.id),
                        ),
                      );
                    },
                  );
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (err, _) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Falha ao buscar filmes: $err'),
              ),
            ),
          ),
        ];
      },
      viewOnOpen: () => searchController.clear(),
    );
  }
}
