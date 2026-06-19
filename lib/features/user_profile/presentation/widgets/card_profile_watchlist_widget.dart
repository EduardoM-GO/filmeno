import 'package:filmeno/features/movie_details/presentation/movie_details_page_widget.dart';
import 'package:filmeno/features/user_profile/domain/user_interaction_movie.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/library_poster_widget.dart';
import 'package:flutter/material.dart';

final class CardProfileWatchlistWidget extends StatelessWidget {
  final UserInteractionMovie movie;

  const CardProfileWatchlistWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = movie.status.color;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(10, 8, 12, 8),
        leading: LibraryPosterWidget(posterPath: movie.posterPath),
        title: Text(
          movie.title,
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.w800),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color.alphaBlend(
                      statusColor.withValues(alpha: 0.18),
                      theme.colorScheme.surfaceContainerHigh,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(color: statusColor.withValues(alpha: 0.45)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(movie.status.iconSelected,
                            size: 14, color: statusColor),
                        const SizedBox(width: 5),
                        Text(
                          movie.status.label.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Text(
                      movie.mediaType.name.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailsPageWidget(
                mediaId: movie.id,
                mediaType: movie.mediaType,
              ),
            ),
          );
        },
      ),
    );
  }
}
