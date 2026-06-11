import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/trending_repository.dart';
import '../domain/trending_movie.dart';

part 'trending_notifier.g.dart';

@riverpod
class TrendingMovies extends _$TrendingMovies {
  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasReachedEnd = false;

  @override
  Future<List<TrendingMovie>> build() async {
    _currentPage = 1;
    _hasReachedEnd = false;
    _isFetchingMore = false;

    return _fetchPage(page: _currentPage);
  }

  Future<List<TrendingMovie>> _fetchPage({required int page}) async {
    final repository = ref.watch(trendingRepositoryProvider);
    final result = await repository.getTrendingMovies(page: page).run();

    return result.match(
      (falha) => throw Exception(falha.mensagem),
      (movies) {
        if (movies.isEmpty) _hasReachedEnd = true;
        return movies;
      },
    );
  }

  Future<void> fetchNextPage() async {
    if (_isFetchingMore || _hasReachedEnd) return;

    _isFetchingMore = true;
    _currentPage++;

    final previousState = state.value ?? [];

    try {
      final newMovies = await _fetchPage(page: _currentPage);

      state = AsyncData([...previousState, ...newMovies]);
    } catch (e, stack) {
      _currentPage--;
      state = AsyncError(e, stack);
    } finally {
      _isFetchingMore = false;
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}
