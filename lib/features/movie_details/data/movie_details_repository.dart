import 'package:filmeno/features/movie_details/domain/watch_provider.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/functional_client.dart';
import '../../../core/network/network_providers.dart';
import '../../../shared/exceptions/falha.dart';
import '../domain/movie_details.dart';

class MovieDetailsRepository {
  final FunctionalClient _client;
  MovieDetailsRepository(this._client);

  TaskEither<Falha, MovieDetails> getDetails(int movieId) {
    return _client.get('/movie/$movieId', params: {
      'append_to_response': 'credits,watch/providers',
      'language': 'pt-BR',
    }).map((response) {
      final providersData = response['watch/providers']?['results']?['BR'];
      final flatrate = providersData?['flatrate'] as List? ?? [];

      // Mapeamos para o nosso modelo
      final providers = flatrate.map((p) => WatchProvider.fromMap(p)).toList();
      final link = providersData?['link'] as String?;

      return MovieDetails.fromMap(map: response, providers: providers, watchLink: link ?? '');
    });
  }
}

final movieDetailsRepositoryProvider = Provider((ref) {
  final client = ref.watch(functionalClientProvider);
  return MovieDetailsRepository(client);
});
