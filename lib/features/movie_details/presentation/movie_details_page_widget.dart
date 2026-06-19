import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/ui_kit/widgets/app_error_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_loading_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/movie_interaction_controls_widget.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_notifier.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_cast_section_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_header_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_overview_section_widget.dart';
import 'package:filmeno/features/movie_details/presentation/widgets/movie_details_streaming_section_widget.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/api_config.dart';
import '../../../core/theme/dynamic_theme_provider.dart';

class MovieDetailsPageWidget extends HookConsumerWidget {
  final int mediaId;
  final MediaTypeEnum mediaType;

  const MovieDetailsPageWidget({
    super.key,
    required this.mediaId,
    required this.mediaType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailsAsync = ref.watch(movieDetailsProvider(mediaId, mediaType));

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
              child: MovieInteractionControlsWidget(
                  mediaId: movie.id,
                  mediaType: movie.mediaType,
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
        loading: () =>
            const AppLoadingStateWidget(label: 'Abrindo ficha do título...'),
        error: (err, stack) => AppErrorStateWidget(error: err),
      ),
    );
  }
}
