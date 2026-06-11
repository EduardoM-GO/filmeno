import 'package:fpdart/fpdart.dart';
import 'package:sembast/sembast.dart';

import '../../../core/network/functional_client.dart';
import '../../../shared/exceptions/falha.dart';
import '../../movie_trending/domain/trending_movie.dart';

class RecommendationsRepository {
  final FunctionalClient _client;
  final Database _db;

  final _profileStore = intMapStoreFactory.store('user_profile');
  final _moviesStore = intMapStoreFactory.store('movies_interactions');
  final int _profileKey = 1;

  RecommendationsRepository(this._client, this._db);

  /// Busca filmes recomendados baseados na matriz de gêneros local
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

        // 3. Fazer a requisição ao /discover/movie do TMDB
        final response = await _client.get('/discover/movie', params: {
          'language': 'pt-BR',
          'with_genres': genresParam,
          'sort_by': 'popularity.desc', // Traz os mais populares dentro daqueles gêneros
        }).run();

        return response.match(
          (falha) => throw falha,
          (json) async {
            final results = json['results'] as List;
            final apiMovies = results.map((m) => TrendingMovie.fromMap(m)).toList();

            // 4. FILTRO DE EXPULSÃO: Pegar IDs de filmes que o usuário já interagiu para limpar a lista
            final userMoviesSnapshot = await _moviesStore.find(_db);
            final excludedIds = userMoviesSnapshot.map((s) => s.key).toSet();

            // Retorna apenas os filmes inéditos para o usuário
            return apiMovies.where((movie) => !excludedIds.contains(movie.id)).toList();
          },
        );
      },
      (error, __) => FalhaDesconhecida('Erro no motor de recomendações: $error'),
    );
  }
}
