import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';

final class MovieDetailsHeaderWidget extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsHeaderWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backdropUrl =
        movie.backdropPath.isEmpty ? null : '${ApiConfig.baseImageUrl}w780${movie.backdropPath}';

    return SliverAppBar(
      expandedHeight: 360.0,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(movie.title),
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16, end: 64),
        centerTitle: false,
        background: Stack(
          fit: StackFit.expand,
          children: [
            if (backdropUrl == null)
              ColoredBox(
                color: theme.colorScheme.surfaceContainerHighest,
                child: Icon(
                  Icons.movie_creation_outlined,
                  size: 72,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            else
              CachedNetworkImage(
                imageUrl: backdropUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                ),
                errorWidget: (context, url, error) => ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image_outlined,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    theme.colorScheme.surface,
                    theme.colorScheme.surface.withValues(alpha: 0.14),
                    theme.colorScheme.surface,
                  ],
                  stops: const [0, 0.48, 1],
                ),
              ),
            ),
            if (movie.posterPath.isNotEmpty)
              Positioned(
                left: 16,
                bottom: 72,
                child: Hero(
                  tag: '${movie.mediaType.storageValue}-poster-${movie.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConfig.baseImageUrl}w185${movie.posterPath}',
                      width: 86,
                      height: 128,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
