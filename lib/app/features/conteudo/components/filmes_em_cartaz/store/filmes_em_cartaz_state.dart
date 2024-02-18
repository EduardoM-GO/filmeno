part of 'filmes_em_cartaz_store.dart';

sealed class FilmesEmCartazState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class FilmesEmCartazInicialState extends FilmesEmCartazState {}

final class FilmesEmCartazCarregandoState extends FilmesEmCartazState {}

final class FilmesEmCartazSucessoState extends FilmesEmCartazState {
  final List<Filme> filmes;

  FilmesEmCartazSucessoState(this.filmes);

  @override
  List<Object?> get props => [filmes];
}

final class FilmesEmCartazTodosFilmesCarregadosState
    extends FilmesEmCartazState {
  final List<Filme> filmes;

  FilmesEmCartazTodosFilmesCarregadosState(this.filmes);
  @override
  List<Object?> get props => [filmes];
}

final class FilmesEmCartazFalhaState extends FilmesEmCartazState {}
