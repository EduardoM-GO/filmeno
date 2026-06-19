import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/search_repository.dart';
import '../domain/search_result.dart';

part 'movie_search_notifier.g.dart';

@riverpod
class MovieSearchNotifier extends _$MovieSearchNotifier {
  Timer? _debounceTimer;
  int _searchVersion = 0;

  @override
  FutureOr<List<SearchResult>> build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    return [];
  }

  Future<void> search(String query) async {
    _debounceTimer?.cancel();
    final trimmedQuery = query.trim();
    final searchVersion = ++_searchVersion;

    if (trimmedQuery.length < 2) {
      state = const AsyncData([]);
      return;
    }

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncLoading();

      final repository = ref.read(searchRepositoryProvider);

      final result = await repository.searchMulti(trimmedQuery).run();

      if (!ref.mounted || searchVersion != _searchVersion) return;

      state = result.match(
        (falha) => AsyncError(falha.mensagem, StackTrace.current),
        (list) => AsyncData(list),
      );
    });
  }
}
