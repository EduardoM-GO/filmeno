import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_notifier.dart';
import 'package:filmeno/features/movie_watchlist/presentation/watchlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_config.dart';
import '../../../core/theme/dynamic_theme_provider.dart';

class MovieDetailsPage extends HookConsumerWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(movieDetailsProvider(movieId));

    final watchlistAsync = ref.watch(watchlistProvider);
    final isSaved = watchlistAsync.maybeWhen(
      data: (list) => list.any((m) => m['id'] == movieId),
      orElse: () => false,
    );

    useEffect(() {
      detailsAsync.whenData((details) {
        final imageProvider = CachedNetworkImageProvider(
          '${ApiConfig.baseImageUrl}w500${details.posterPath}',
        );

        ref.read(appThemeProvider.notifier).updateThemeFromImage(imageProvider);
      });
      return null;
    }, [detailsAsync.hasValue]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalhes',
        ),
        actions: [
          IconButton(
            icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
            onPressed: () {
              final movie = detailsAsync.value;
              if (movie != null) {
                ref.read(watchlistProvider.notifier).toggleMovie({
                  'id': movie.id,
                  'title': movie.title,
                  'poster_path': movie.posterPath,
                });
              }
            },
          ),
        ],
      ),
      body: detailsAsync.when(
        data: (movie) => SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: '${ApiConfig.baseImageUrl}w780${movie.backdropPath}'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 10),
                    Text(movie.overview),
                    const SizedBox(height: 20),
                    Text('Elenco Principal:', style: Theme.of(context).textTheme.titleLarge),
                    Text(movie.cast.join(', ')),
                  ],
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }
}
