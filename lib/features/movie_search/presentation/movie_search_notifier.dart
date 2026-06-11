import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/search_repository.dart';
import '../domain/search_result.dart';

part 'movie_search_notifier.g.dart';

@riverpod
class MovieSearchNotifier extends _$MovieSearchNotifier {
  Timer? _debounceTimer;

  @override
  FutureOr<List<SearchResult>> build() {
    ref.onDispose(() => _debounceTimer?.cancel());
    return [];
  }

  Future<void> search(String query) async {
    _debounceTimer?.cancel();

    if (query.trim().length < 2) {
      state = const AsyncData([]);
      return;
    }

    ///Todo: Verificar porque não está funcionando
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      state = const AsyncLoading();

      final repository = ref.read(searchRepositoryProvider);

      final result = await repository.searchMulti(query).run();

      if (!ref.mounted) return;

      state = result.match(
        (falha) => AsyncError(falha.mensagem, StackTrace.current),
        (list) => AsyncData(list),
      );
    });
  }
}
