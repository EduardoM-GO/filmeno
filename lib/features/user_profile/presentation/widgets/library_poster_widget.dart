import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/library_poster_fallback_widget.dart';
import 'package:flutter/material.dart';

final class LibraryPosterWidget extends StatelessWidget {
  final String posterPath;

  const LibraryPosterWidget({super.key, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (posterPath.isEmpty) {
      return LibraryPosterFallbackWidget(colorScheme: colorScheme);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        imageUrl: '${ApiConfig.baseImageUrl}w92$posterPath',
        fit: BoxFit.cover,
        width: 54,
        height: 80,
        placeholder: (context, url) => Container(
          width: 54,
          height: 80,
          color: colorScheme.surfaceContainerHighest,
        ),
        errorWidget: (context, url, error) =>
            LibraryPosterFallbackWidget(colorScheme: colorScheme),
      ),
    );
  }
}
