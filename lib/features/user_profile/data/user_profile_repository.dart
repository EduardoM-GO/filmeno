import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../shared/exceptions/falha.dart';
import '../domain/user_interaction_movie.dart';

class UserProfileRepository {
  final Database _db;

  final _moviesStore = intMapStoreFactory.store('movies_interactions');
  final _profileStore = intMapStoreFactory.store('user_profile');
  final int _profileKey = 1;

  UserProfileRepository(this._db);

  TaskEither<Falha, Unit> saveMovieInteraction(UserInteractionMovie movie) {
    return TaskEither.tryCatch(
      () async {
        await _moviesStore.record(movie.id).put(_db, movie.toMap());
        return unit;
      },
      (error, __) => FalhaNoBancoDeDados('Erro ao salvar interação: $error'),
    );
  }

  TaskEither<Falha, Unit> deleteMovieInteraction(int movieId) {
    return TaskEither.tryCatch(
      () async {
        await _moviesStore.record(movieId).delete(_db);
        return unit;
      },
      (error, __) => FalhaNoBancoDeDados('Erro ao remover interação: $error'),
    );
  }

  TaskEither<Falha, List<UserInteractionMovie>> getAllInteractedMovies() {
    return TaskEither.tryCatch(
      () async {
        final snapshots = await _moviesStore.find(_db);
        return snapshots.map((s) => UserInteractionMovie.fromMap(s.value)).toList();
      },
      (error, __) => FalhaNoBancoDeDados('Erro ao buscar interações: $error'),
    );
  }

  Stream<List<UserInteractionMovie>> watchMovies() {
    return _moviesStore.query().onSnapshots(_db).map((snapshots) {
      return snapshots.map((s) => UserInteractionMovie.fromMap(s.value)).toList();
    });
  }

  Future<void> saveGenreScores(Map<String, int> scores) async {
    await _profileStore.record(_profileKey).put(_db, {
      'genres_score': scores,
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}
