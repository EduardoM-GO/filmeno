import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../core/network/functional_client.dart';
import '../../../shared/exceptions/falha.dart';
import '../../movie_search/domain/enums/media_type_enum.dart';
import '../../movie_trending/domain/trending_movie.dart';

class RecommendationsRepository {
  final FunctionalClient _client;
  final Database _db;

  final _profileStore = intMapStoreFactory.store('user_profile');
  final _moviesStore = stringMapStoreFactory.store('movies_interactions');
  final int _profileKey = 1;

  RecommendationsRepository(this._client, this._db);

  /// Busca títulos recomendados baseados na matriz de gêneros local.
  TaskEither<Falha, List<TrendingMovie>> getRecommendedMovies() {
    return TaskEither.tryCatch(
      () async {
        // 1. Buscar as pontuações de gêneros no Sembast
        final profileDoc = await _profileStore.record(_profileKey).get(_db);

        // Se o perfil não existir ou não tiver pontos, retorna vazio (a UI fará o fallback)
        if (profileDoc == null || profileDoc['genres_score'] == null) {
          return <TrendingMovie>[];
        }

        final scores = Map<String, int>.from(profileDoc['genres_score'] as Map);

        // 2. Filtrar os 3 gêneros com maior pontuação (e que sejam positivos)
        final topGenres = scores.entries.where((entry) => entry.value > 0).toList()
          ..sort((a, b) => b.value.compareTo(a.value)); // Ordenação decrescente

        final genreIdsIds = topGenres.take(3).map((e) => e.key).toList();

        // Fallback se o usuário só tiver negativado gêneros até agora
        if (genreIdsIds.isEmpty) return <TrendingMovie>[];

        // Criamos a string para o parâmetro with_genres separando por '|' (Operador OR do TMDB)
        final genresParam = genreIdsIds.join('|');

        final recommendedMovies = await _discoverByGenres(
          endpoint: '/discover/movie',
          genresParam: genresParam,
          fallbackMediaType: MediaTypeEnum.movie,
        ).run();

        final recommendedSeries = await _discoverByGenres(
          endpoint: '/discover/tv',
          genresParam: genresParam,
          fallbackMediaType: MediaTypeEnum.tv,
        ).run();

        final apiTitles = [
          ...recommendedMovies.match((falha) => throw falha, (movies) => movies),
          ...recommendedSeries.match((falha) => throw falha, (series) => series),
        ];

        final userMoviesSnapshot = await _moviesStore.find(_db);
        final excludedIds = userMoviesSnapshot.map((s) => s.key).toSet();

        return apiTitles
            .where(
              (title) => !excludedIds.contains('${title.mediaType.storageValue}:${title.id}'),
            )
            .toList();
      },
      (error, stack) => FalhaDesconhecida(
          msg: 'Erro no motor de recomendações: $error', erro: error, stack: stack),
    );
  }

  TaskEither<Falha, List<TrendingMovie>> _discoverByGenres({
    required String endpoint,
    required String genresParam,
    required MediaTypeEnum fallbackMediaType,
  }) {
    return _client.get(endpoint, params: {
      'language': 'pt-BR',
      'with_genres': genresParam,
      'sort_by': 'popularity.desc',
    }).map((json) {
      final results = json['results'] as List;
      return results
          .map((m) => TrendingMovie.fromMap(m, fallbackMediaType: fallbackMediaType))
          .toList();
    });
  }
}
