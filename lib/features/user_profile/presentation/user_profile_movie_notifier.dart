import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/sembast_provider.dart';
import '../data/user_profile_repository.dart';
import '../domain/user_interaction_movie.dart';

part 'user_profile_movie_notifier.g.dart';

@riverpod
class UserProfileMovieNotifier extends _$UserProfileMovieNotifier {
  @override
  Stream<List<UserInteractionMovie>> build() async* {
    final db = await ref.watch(sembastDatabaseProvider.future);
    final repository = UserProfileRepository(db);

    yield* repository.watchMovies();
  }

  Future<void> updateStatus({
    required int movieId,
    required String title,
    required String posterPath,
    required List<int> genreIds,
    required MovieInteractionStatusEnum newStatus,
  }) async {
    final db = await ref.read(sembastDatabaseProvider.future);
    final repository = UserProfileRepository(db);

    if (newStatus == MovieInteractionStatusEnum.none) {
      await repository.deleteMovieInteraction(movieId).run();
    } else {
      final interaction = UserInteractionMovie(
        id: movieId,
        title: title,
        posterPath: posterPath,
        genreIds: genreIds,
        status: newStatus,
        updatedAt: DateTime.now(),
      );
      await repository.saveMovieInteraction(interaction).run();
    }

    await _recalculateScores(repository);
  }

  Future<void> _recalculateScores(UserProfileRepository repository) async {
    final result = await repository.getAllInteractedMovies().run();
    final movies = result.getOrElse((_) => []);

    final Map<String, int> newScores = {};

    for (final movie in movies) {
      final int weight = movie.status.weight;

      for (final genreId in movie.genreIds) {
        final currentScore = newScores[genreId.toString()] ?? 0;

        newScores[genreId.toString()] = (currentScore + weight).clamp(-20, 20);
      }
    }

    await repository.saveGenreScores(newScores);
  }
}
