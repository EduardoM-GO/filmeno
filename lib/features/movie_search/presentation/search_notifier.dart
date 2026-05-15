import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/search_repository.dart';
import '../domain/search_result.dart';

part 'search_notifier.g.dart';

@riverpod
class MovieSearch extends _$MovieSearch {
  @override
  FutureOr<List<SearchResult>> build() => [];

  Future<void> search(String query) async {
    if (query.length < 2) {
      state = const AsyncData([]);
      return;
    }

    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 500));

    final repository = ref.read(searchRepositoryProvider);
    final result = await repository.searchMulti(query).run();

    state = result.match(
      (falha) => AsyncError(falha.mensagem, StackTrace.current),
      (list) => AsyncData(list),
    );
  }
}
