import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';

final class MovieDetailsCastSectionWidget extends StatelessWidget {
  final MovieDetails movie;
  const MovieDetailsCastSectionWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    if (movie.cast.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Elenco principal',
          style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final actor in movie.cast)
              Chip(
                avatar: const Icon(Icons.person_outline, size: 18),
                label: Text(actor),
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
              ),
          ],
        ),
      ],
    );
  }
}
