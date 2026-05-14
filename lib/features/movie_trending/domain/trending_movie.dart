final class TrendingMovie {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;

  TrendingMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.voteAverage,
  });

  // Factory para converter o JSON do TMDB para a nossa entidade
  factory TrendingMovie.fromMap(Map<String, dynamic> map) {
    return TrendingMovie(
      id: map['id'] ?? 0,
      title: map['title'] ?? map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      voteAverage: (map['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
