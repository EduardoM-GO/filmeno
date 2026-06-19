import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/movie_details_repository.dart';
import '../domain/movie_details.dart';

part 'movie_details_notifier.g.dart';

@riverpod
class MovieDetailsNotifier extends _$MovieDetailsNotifier {
  @override
  FutureOr<MovieDetails> build(int mediaId, MediaTypeEnum mediaType) async {
    final repository = ref.watch(movieDetailsRepositoryProvider);
    final result = await repository
        .getDetails(mediaId: mediaId, mediaType: mediaType)
        .run();

    return result.match(
      (falha) => throw Exception(falha.mensagem),
      (details) => details,
    );
  }
}
