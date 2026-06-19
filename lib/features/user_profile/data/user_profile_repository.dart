import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../shared/exceptions/falha.dart';
import '../domain/user_interaction_movie.dart';

class UserProfileRepository {
  final Database _db;

  final _moviesStore = stringMapStoreFactory.store('movies_interactions');
  final _profileStore = intMapStoreFactory.store('user_profile');
  final int _profileKey = 1;

  UserProfileRepository(this._db);

  TaskEither<Falha, Unit> saveMovieInteraction(UserInteractionMovie movie) {
    return TaskEither.tryCatch(
      () async {
        await _moviesStore.record(movie.interactionKey).put(_db, movie.toMap());
        return unit;
      },
      (error, stack) =>
          FalhaNoBancoDeDados(msg: 'Erro ao salvar interação: $error', erro: error, stack: stack),
    );
  }

  TaskEither<Falha, Unit> deleteMovieInteraction(String interactionKey) {
    return TaskEither.tryCatch(
      () async {
        await _moviesStore.record(interactionKey).delete(_db);
        return unit;
      },
      (error, stack) =>
          FalhaNoBancoDeDados(msg: 'Erro ao remover interação: $error', erro: error, stack: stack),
    );
  }

  TaskEither<Falha, List<UserInteractionMovie>> getAllInteractedMovies() {
    return TaskEither.tryCatch(
      () async {
        final snapshots = await _moviesStore.find(_db);
        return snapshots.map((s) => UserInteractionMovie.fromMap(s.value)).toList();
      },
      (error, stack) =>
          FalhaNoBancoDeDados(msg: 'Erro ao buscar interações: $error', erro: error, stack: stack),
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
