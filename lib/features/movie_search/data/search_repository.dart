import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/network/functional_client.dart';
import '../../../core/network/network_providers.dart';
import '../../../shared/exceptions/falha.dart';
import '../domain/search_result.dart';

final class SearchRepository {
  final FunctionalClient _client;
  SearchRepository(this._client);

  TaskEither<Falha, List<SearchResult>> searchMulti(String query) {
    if (query.isEmpty) return TaskEither.right([]);

    return _client.get('/search/multi', params: {
      'query': query,
      'include_adult': 'true',
      'language': 'pt-BR',
    }).map((response) {
      final results = response['results'] as List;
      return results
          .map((m) => SearchResult.fromMap(m))
          .where((result) => result.mediaType.isSupported)
          .toList();
    });
  }
}

// Provider para o repositório
final searchRepositoryProvider = Provider((ref) {
  final client = ref.watch(functionalClientProvider);
  return SearchRepository(client);
});
