enum MediaTypeEnum {
  movie,
  tv,
  unknown;

  static MediaTypeEnum fromString(String? value) {
    return switch (value) {
      'movie' => MediaTypeEnum.movie,
      'tv' => MediaTypeEnum.tv,
      _ => MediaTypeEnum.unknown,
    };
  }

  String get name => switch (this) {
        MediaTypeEnum.movie => 'Filme',
        MediaTypeEnum.tv => 'Série',
        MediaTypeEnum.unknown => 'Desconhecido',
      };
}
