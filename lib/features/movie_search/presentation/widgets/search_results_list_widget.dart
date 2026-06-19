import 'package:filmeno/features/movie_search/domain/search_result.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/search_result_tile_widget.dart';
import 'package:flutter/material.dart';

final class SearchResultsListWidget extends StatelessWidget {
  final List<SearchResult> results;

  const SearchResultsListWidget({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        return SearchResultTileWidget(movie: results[index]);
      },
    );
  }
}
