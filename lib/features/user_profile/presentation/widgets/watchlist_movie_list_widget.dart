import 'package:filmeno/features/user_profile/domain/user_interaction_movie.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/card_profile_watchlist_widget.dart';
import 'package:flutter/material.dart';

final class WatchlistMovieListWidget extends StatelessWidget {
  final List<UserInteractionMovie> movies;

  const WatchlistMovieListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemCount: movies.length,
      itemBuilder: (context, index) =>
          CardProfileWatchlistWidget(movie: movies[index]),
    );
  }
}
