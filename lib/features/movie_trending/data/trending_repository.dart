import 'package:filmeno/core/network/network_providers.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/functional_client.dart';
import '../../../shared/exceptions/falha.dart';
import '../domain/trending_movie.dart';

class TrendingRepository {
  final FunctionalClient _client;
  TrendingRepository(this._client);

  TaskEither<Falha, List<TrendingMovie>> getTrendingMovies({int page = 1}) {
    return _client.get('/trending/movie/day', params: {
      'language': 'pt-BR',
      'page': '$page',
    }).map((response) {
      final results = response['results'] as List;
      return results.map((m) => TrendingMovie.fromMap(m)).toList();
    });
  }
}

final trendingRepositoryProvider = Provider.autoDispose<TrendingRepository>((ref) {
  final client = ref.watch(functionalClientProvider);
  return TrendingRepository(client);
});
