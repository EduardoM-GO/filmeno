import 'package:flutter/material.dart';

import '../../../features/movie_trending/domain/trending_movie.dart';
import '../../../features/movie_trending/presentation/widgets/movie_card_widget.dart';

final class AdaptiveMovieGridWidget extends StatelessWidget {
  final List<TrendingMovie> movies;
  final ScrollController? controller;
  final bool showLoadingFooter;
  final EdgeInsetsGeometry padding;

  const AdaptiveMovieGridWidget({
    super.key,
    required this.movies,
    this.controller,
    this.showLoadingFooter = false,
    this.padding = const EdgeInsets.fromLTRB(16, 12, 16, 24),
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = switch (width) {
          >= 1200 => 6,
          >= 900 => 5,
          >= 680 => 4,
          >= 460 => 3,
          _ => 2,
        };

        return GridView.builder(
          controller: controller,
          padding: padding,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.62,
            crossAxisSpacing: 14,
            mainAxisSpacing: 16,
          ),
          itemCount: movies.length + (showLoadingFooter ? crossAxisCount : 0),
          itemBuilder: (context, index) {
            if (index >= movies.length) {
              return const Center(
                child: SizedBox.square(
                  dimension: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            }

            return MovieCardWidget(movie: movies[index]);
          },
        );
      },
    );
  }
}
