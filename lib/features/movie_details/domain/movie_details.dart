import 'package:filmeno/features/movie_details/domain/movie_gender.dart';
import 'package:filmeno/features/movie_details/domain/watch_provider.dart';

final class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final List<MovieGender> genres;
  final List<String> cast;
  final List<WatchProvider> streamingProviders;
  final String watchLink;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
    required this.cast,
    required this.streamingProviders,
    required this.watchLink,
  });

  factory MovieDetails.fromMap(
      {required List<WatchProvider> providers,
      required String watchLink,
      required Map<String, dynamic> map}) {
    final credits = map['credits']?['cast'] as List? ?? [];
    return MovieDetails(
        id: map['id'] ?? 0,
        title: map['title'] ?? '',
        overview: map['overview'] ?? '',
        backdropPath: map['backdrop_path'] ?? '',
        posterPath: map['poster_path'] ?? '',
        genres: (map['genres'] as List?)?.map((g) => MovieGender.fromMap(g)).toList() ?? [],
        cast: credits.take(5).map((c) => c['name'] as String).toList(),
        streamingProviders: providers,
        watchLink: watchLink);
  }
}
