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

  String get endpointSegment => switch (this) {
        MediaTypeEnum.movie => 'movie',
        MediaTypeEnum.tv => 'tv',
        MediaTypeEnum.unknown => 'movie',
      };

  String get storageValue => switch (this) {
        MediaTypeEnum.movie => 'movie',
        MediaTypeEnum.tv => 'tv',
        MediaTypeEnum.unknown => 'unknown',
      };

  bool get isSupported =>
      this == MediaTypeEnum.movie || this == MediaTypeEnum.tv;

  String get name => switch (this) {
        MediaTypeEnum.movie => 'Filme',
        MediaTypeEnum.tv => 'Série',
        MediaTypeEnum.unknown => 'Desconhecido',
      };
}
