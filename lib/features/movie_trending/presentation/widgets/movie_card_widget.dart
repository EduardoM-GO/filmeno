import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_page_widget.dart';
import 'package:filmeno/features/movie_trending/presentation/widgets/poster_gradient_widget.dart';
import 'package:filmeno/features/movie_trending/presentation/widgets/rating_badge_widget.dart';
import 'package:flutter/material.dart';

import '../../domain/trending_movie.dart';

class MovieCardWidget extends StatelessWidget {
  final TrendingMovie movie;

  const MovieCardWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageUrl = movie.posterPath.isEmpty
        ? null
        : '${ApiConfig.baseImageUrl}w500${movie.posterPath}';

    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      closedColor: Colors.transparent,
      closedElevation: 0,
      openBuilder: (context, _) => MovieDetailsPageWidget(
        mediaId: movie.id,
        mediaType: movie.mediaType,
      ),
      closedBuilder: (context, openContainer) => InkWell(
        onTap: openContainer,
        borderRadius: BorderRadius.circular(8),
        child: Card(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Hero(
                tag: '${movie.mediaType.storageValue}-poster-${movie.id}',
                child: imageUrl == null
                    ? DecoratedBox(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceContainerHighest,
                        ),
                        child: Icon(
                          Icons.movie_creation_outlined,
                          size: 40,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      )
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                        ),
                        errorWidget: (context, url, error) => DecoratedBox(
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          child: Icon(
                            Icons.broken_image_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
              ),
              const PosterGradientWidget(),
              Positioned(
                top: 10,
                right: 10,
                child: RatingBadgeWidget(voteAverage: movie.voteAverage),
              ),
              Positioned(
                left: 12,
                right: 12,
                bottom: 12,
                child: Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    shadows: const [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
