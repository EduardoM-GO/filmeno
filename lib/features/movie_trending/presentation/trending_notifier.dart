import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/trending_repository.dart';
import '../domain/trending_movie.dart';

part 'trending_notifier.g.dart';

@riverpod
class TrendingMovies extends _$TrendingMovies {
  @override
  Future<List<TrendingMovie>> build() async {
    final repository = ref.watch(trendingRepositoryProvider);

    final result = await repository.getTrendingMovies().run();

    return result.match(
      (falha) => throw Exception(falha.mensagem),
      (movies) => movies,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}
