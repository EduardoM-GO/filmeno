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
      'append_to_response': 'credits',
      'language': 'pt-BR',
    }).map((response) => MovieDetails.fromMap(response));
  }
}

final movieDetailsRepositoryProvider = Provider((ref) {
  final client = ref.watch(functionalClientProvider);
  return MovieDetailsRepository(client);
});
