import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/sembast_provider.dart';
import '../data/watchlist_repository.dart';

part 'watchlist_notifier.g.dart';

@riverpod
class Watchlist extends _$Watchlist {
  @override
  Stream<List<Map<String, dynamic>>> build() async* {
    // Obtemos a instância do banco (que é um Future)
    final db = await ref.watch(sembastDatabaseProvider.future);
    final repository = WatchlistRepository(db);

    // Retornamos a stream reativa do Sembast
    yield* repository.watchWatchlist();
  }

  /// Adiciona ou remove um filme da lista
  Future<void> toggleMovie(Map<String, dynamic> movieJson) async {
    final db = await ref.read(sembastDatabaseProvider.future);
    final repository = WatchlistRepository(db);

    // Usamos o TaskEither para garantir que erros de IO não crasham o app
    await repository.saveMovie(movieJson).run();
  }
}
