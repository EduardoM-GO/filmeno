import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/movie_details_repository.dart';
import '../domain/movie_details.dart';

part 'movie_details_notifier.g.dart';

@riverpod
class MovieDetailsNotifier extends _$MovieDetailsNotifier {
  @override
  FutureOr<MovieDetails> build(int movieId) async {
    final repository = ref.watch(movieDetailsRepositoryProvider);
    final result = await repository.getDetails(movieId).run();

    return result.match(
      (falha) => throw Exception(falha.mensagem),
      (details) => details,
    );
  }
}
