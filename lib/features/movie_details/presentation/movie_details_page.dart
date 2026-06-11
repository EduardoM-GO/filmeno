import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/ui_kit/widgets/movie_interaction_controls.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_notifier.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_cast_section_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_header_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_overview_section_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_streaming_section_widget.dart';
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
      body: detailsAsync.when(
        data: (movie) => CustomScrollView(
          slivers: [
            MovieDetailsHeaderWidget(
              movie: movie,
            ),
            SliverFloatingHeader(
              child: MovieInteractionControls(
                  movieId: movie.id,
                  title: movie.title,
                  posterPath: movie.posterPath,
                  genreIds: movie.genres.map((g) => g.id).toList()),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  MovieDetailsOverviewSectionWidget(movie: movie),
                  if (movie.streamingProviders.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    MovieDetailsStreamingSectionWidget(movie: movie),
                  ],
                  const SizedBox(height: 24),
                  MovieDetailsCastSectionWidget(movie: movie),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }
}
