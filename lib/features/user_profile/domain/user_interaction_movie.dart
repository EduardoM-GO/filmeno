import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';
import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';

final class UserInteractionMovie {
  final int id;
  final String title;
  final MediaTypeEnum mediaType;
  final String posterPath;
  final List<int> genreIds;
  final MovieInteractionStatusEnum status;
  final DateTime updatedAt;

  UserInteractionMovie({
    required this.id,
    required this.title,
    required this.mediaType,
    required this.posterPath,
    required this.genreIds,
    required this.status,
    required this.updatedAt,
  });

  String get interactionKey => '${mediaType.storageValue}:$id';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'media_type': mediaType.storageValue,
      'poster_path': posterPath,
      'genre_ids': genreIds,
      'status': status.name,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory UserInteractionMovie.fromMap(Map<String, dynamic> map) {
    return UserInteractionMovie(
      id: map['id'] as int,
      title: map['title'] as String,
      mediaType:
          MediaTypeEnum.fromString(map['media_type'] as String?).isSupported
              ? MediaTypeEnum.fromString(map['media_type'] as String?)
              : MediaTypeEnum.movie,
      posterPath: map['poster_path'] ?? '',
      genreIds: List<int>.from(map['genre_ids'] ?? []),
      status: MovieInteractionStatusEnum.fromName(map['status'] as String?),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }
}
