import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';

final class MovieDetailsCastSectionWidget extends StatelessWidget {
  final MovieDetails movie;
  const MovieDetailsCastSectionWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elenco Principal', style: textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          movie.cast.join(', '),
          style:
              textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
