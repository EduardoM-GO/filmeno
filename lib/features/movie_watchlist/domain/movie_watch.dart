import 'package:filmeno/features/movie_details/domain/movie_details.dart';

final class MovieWatch {
  final int id;
  final String title;
  final String posterPath;

  MovieWatch({
    required this.id,
    required this.title,
    required this.posterPath,
  });

  factory MovieWatch.movieDetails(MovieDetails movieDetails) {
    return MovieWatch(
      id: movieDetails.id,
      title: movieDetails.title,
      posterPath: movieDetails.posterPath,
    );
  }

  factory MovieWatch.fromMap(Map<String, dynamic> map) {
    return MovieWatch(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }
}
