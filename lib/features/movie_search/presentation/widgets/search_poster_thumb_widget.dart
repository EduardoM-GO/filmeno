import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/poster_fallback_widget.dart';
import 'package:flutter/material.dart';

final class SearchPosterThumbWidget extends StatelessWidget {
  final int mediaId;
  final MediaTypeEnum mediaType;
  final String posterPath;

  const SearchPosterThumbWidget({
    super.key,
    required this.mediaId,
    required this.mediaType,
    required this.posterPath,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (posterPath.isEmpty) {
      return PosterFallbackWidget(colorScheme: colorScheme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Hero(
        tag: '${mediaType.storageValue}-poster-$mediaId',
        child: CachedNetworkImage(
          width: 50,
          height: 75,
          fit: BoxFit.cover,
          imageUrl: '${ApiConfig.baseImageUrl}w92$posterPath',
          placeholder: (context, url) => Container(
            width: 50,
            height: 75,
            color: colorScheme.surfaceContainerHighest,
            child:
                const Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          errorWidget: (context, url, error) =>
              PosterFallbackWidget(colorScheme: colorScheme),
        ),
      ),
    );
  }
}
