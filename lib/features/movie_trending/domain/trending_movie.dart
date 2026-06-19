import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';

final class TrendingMovie {
  final int id;
  final String title;
  final String posterPath;
  final MediaTypeEnum mediaType;
  final double voteAverage;

  TrendingMovie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.mediaType,
    required this.voteAverage,
  });

  factory TrendingMovie.fromMap(
    Map<String, dynamic> map, {
    MediaTypeEnum fallbackMediaType = MediaTypeEnum.unknown,
  }) {
    final parsedMediaType =
        MediaTypeEnum.fromString(map['media_type'] as String?);
    final mediaType =
        parsedMediaType.isSupported ? parsedMediaType : fallbackMediaType;

    return TrendingMovie(
      id: map['id'] ?? 0,
      title: map['title'] ?? map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      mediaType: mediaType,
      voteAverage: (map['vote_average'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
