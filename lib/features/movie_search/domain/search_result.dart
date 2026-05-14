import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';

class SearchResult {
  final int id;
  final String title;
  final String posterPath;
  final MediaTypeEnum mediaType;
  final double voteAverage;

  SearchResult({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.mediaType,
    required this.voteAverage,
  });

  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      id: map['id'] ?? 0,
      title: map['title'] ?? map['name'] ?? 'Sem título',
      posterPath: map['poster_path'] ?? '',
      mediaType: MediaTypeEnum.fromString(map['media_type']),
      voteAverage: (map['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
