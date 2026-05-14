import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../shared/exceptions/falha.dart';

class WatchlistRepository {
  final Database _db;
  final _store = intMapStoreFactory.store('watchlist');

  WatchlistRepository(this._db);

  TaskEither<Falha, Unit> saveMovie(Map<String, dynamic> movieJson) {
    return TaskEither.tryCatch(
      () async {
        final key = movieJson['id'] as int;
        await _store.record(key).put(_db, movieJson);
        return unit;
      },
      (error, stack) => FalhaDesconhecida('Erro ao gravar no Sembast.'),
    );
  }

  TaskEither<Falha, List<Map<String, dynamic>>> getWatchlist() {
    return TaskEither.tryCatch(
      () async {
        final snapshots = await _store.find(_db);
        return snapshots.map((s) => s.value).toList();
      },
      (error, stack) => FalhaDesconhecida('Erro ao ler documentos NoSQL.'),
    );
  }

  Stream<List<Map<String, dynamic>>> watchWatchlist() {
    return _store.query().onSnapshots(_db).map(
          (snapshots) => snapshots.map((s) => s.value).toList(),
        );
  }
}
