import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/local_storage/sembast_provider.dart';
import '../../../core/network/network_providers.dart';
import '../../movie_trending/domain/trending_movie.dart';
import '../data/recommendations_repository.dart';

part 'movie_recommendations_notifier.g.dart';

@riverpod
class MovieRecommendationsNotifier extends _$MovieRecommendationsNotifier {
  @override
  Future<List<TrendingMovie>> build() async {
    final client = ref.watch(functionalClientProvider);
    final db = await ref.watch(sembastDatabaseProvider.future);

    final repository = RecommendationsRepository(client, db);
    final result = await repository.getRecommendedMovies().run();

    return result.match(
      (falha) => throw Exception(falha.mensagem),
      (movies) => movies,
    );
  }

  /// Permite forçar uma atualização quando o usuário altera seus gostos na tela de detalhes
  void refresh() {
    state = const AsyncLoading();
    ref.invalidateSelf();
  }
}
