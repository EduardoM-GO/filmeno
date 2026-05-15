import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../shared/exceptions/falha.dart';

class WatchlistRepository {
  final Database _db;
  final _store = intMapStoreFactory.store('watchlist');

  WatchlistRepository(this._db);

  TaskEither<Falha, Unit> toggleMovie(Map<String, dynamic> movieJson) {
    return TaskEither.tryCatch(
      () async {
        final key = movieJson['id'] as int;
        final record = _store.record(key);

        if (record.existsSync(_db)) {
          await record.delete(_db);
        } else {
          await record.put(_db, movieJson);
        }

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
