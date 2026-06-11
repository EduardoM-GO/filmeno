import 'package:filmeno/features/movie_details/presentation/movie_details_page.dart';
import 'package:filmeno/features/user_profile/domain/user_interaction_movie.dart';
import 'package:flutter/material.dart';

final class CardProfileWatchlistWidget extends StatelessWidget {
  final UserInteractionMovie movie;
  const CardProfileWatchlistWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        leading: movie.posterPath.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w92${movie.posterPath}',
                  fit: BoxFit.cover,
                  width: 54,
                  height: 80,
                ),
              )
            : Container(
                width: 54,
                height: 80,
                color: theme.colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.movie_outlined),
              ),
        title: Text(
          movie.title,
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Chip(
            label: Text(movie.status.label.toUpperCase(), style: const TextStyle(fontSize: 10)),
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailsPage(movieId: movie.id),
            ),
          );
        },
      ),
    );
  }
}
