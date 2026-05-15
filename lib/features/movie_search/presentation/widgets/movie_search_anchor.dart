import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../search_notifier.dart';

class MovieSearchAnchor extends ConsumerWidget {
  const MovieSearchAnchor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = SearchController();

    return SearchAnchor(
      searchController: controller,
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => controller.openView(),
        );
      },
      suggestionsBuilder: (context, controller) async {
        final query = controller.text;

        if (query.length < 2) {
          return [
            CinemaEmptyWidget(
              title: 'Digite pelo menos 2 caracteres para buscar.',
              message: '',
              icon: Icons.search,
            ),
          ];
        }

        await ref.read(movieSearchProvider.notifier).search(query);
        final results = ref.read(movieSearchProvider).asData?.value ?? const [];

        if (results.isEmpty) {
          return [
            CinemaEmptyWidget(
              title: 'Cena não encontrada',
              message:
                  'Parece que esse filme fugiu do nosso roteiro. Tente buscar por outro título!',
              icon: Icons.search_off,
            ),
          ];
        }

        return results.map((movie) => ListTile(
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
                          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: colorScheme.surfaceContainerHighest,
                          child: const Icon(Icons.movie_creation_outlined),
                        ),
                      ),
                    )
                  : Container(
                      // Placeholder caso não haja imagem
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
                    MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId: movie.id)));
              },
            ));
      },
      viewOnOpen: () => controller.clear(),
    );
  }
}
