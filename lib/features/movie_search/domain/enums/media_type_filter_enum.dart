import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';

enum MediaTypeFilterEnum {
  all,
  movies,
  series;

  bool matches(MediaTypeEnum mediaType) {
    return switch (this) {
      MediaTypeFilterEnum.all => mediaType.isSupported,
      MediaTypeFilterEnum.movies => mediaType == MediaTypeEnum.movie,
      MediaTypeFilterEnum.series => mediaType == MediaTypeEnum.tv,
    };
  }

  String get label => switch (this) {
        MediaTypeFilterEnum.all => 'Todos',
        MediaTypeFilterEnum.movies => 'Filmes',
        MediaTypeFilterEnum.series => 'Séries',
      };
}
