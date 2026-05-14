final class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final List<String> genres;
  final List<String> cast;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.genres,
    required this.cast,
  });

  factory MovieDetails.fromMap(Map<String, dynamic> map) {
    final credits = map['credits']?['cast'] as List? ?? [];
    return MovieDetails(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      overview: map['overview'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      posterPath: map['poster_path'] ?? '',
      genres: (map['genres'] as List?)?.map((g) => g['name'] as String).toList() ?? [],
      cast: credits.take(5).map((c) => c['name'] as String).toList(),
    );
  }
}
