import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/sembast_provider.dart';
import '../data/watchlist_repository.dart';

part 'watchlist_notifier.g.dart';

@riverpod
class Watchlist extends _$Watchlist {
  @override
  Stream<List<Map<String, dynamic>>> build() async* {
    final db = await ref.watch(sembastDatabaseProvider.future);
    final repository = WatchlistRepository(db);

    yield* repository.watchWatchlist();
  }

  Future<void> toggleMovie(Map<String, dynamic> movieJson) async {
    final db = await ref.read(sembastDatabaseProvider.future);
    final repository = WatchlistRepository(db);

    await repository.toggleMovie(movieJson).run();
  }
}
