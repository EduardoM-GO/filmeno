import 'package:filmeno/features/movie_details/presentation/movie_details_page_widget.dart';
import 'package:filmeno/features/movie_search/domain/search_result.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/search_poster_thumb_widget.dart';
import 'package:flutter/material.dart';

final class SearchResultTileWidget extends StatelessWidget {
  final SearchResult movie;

  const SearchResultTileWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      minLeadingWidth: 50,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: SearchPosterThumbWidget(
        mediaId: movie.id,
        mediaType: movie.mediaType,
        posterPath: movie.posterPath,
      ),
      title: Text(
        movie.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style:
            theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(movie.mediaType.name),
            const SizedBox(width: 8),
            const Icon(Icons.star_rounded, size: 15, color: Color(0xFFFFD166)),
            const SizedBox(width: 2),
            Text(movie.voteAverage.toStringAsFixed(1)),
          ],
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
    );
  }
}
