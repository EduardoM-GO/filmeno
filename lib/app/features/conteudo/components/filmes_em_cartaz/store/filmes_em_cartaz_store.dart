import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/store/store.dart';

part 'filmes_em_cartaz_state.dart';

class FilmesEmCartazStore extends Store<FilmesEmCartazState> {
  final BuscarFilmesEmCartazUseCase _useCase;

  FilmesEmCartazStore(this._useCase) : super(FilmesEmCartazInicialState());

  final List<Filme> _filmes = [];

  int? proximaPagina;
  bool todosFilmesCarregados = false;

  Future<void> buscarFilmesEmCartaz() async {
    if (todosFilmesCarregados) {
      emit(FilmesEmCartazTodosFilmesCarregadosState(_filmes));
      return;
    }

    emit(FilmesEmCartazCarregandoState());
    final result = await _useCase(proximaPagina: proximaPagina);

    emit(result.fold(
      (success) {
        final MetadadosHttp metadados = success.metadados;
        proximaPagina = metadados.proximaPagina;
        todosFilmesCarregados = !metadados.temProximaPagina;

        final List<Filme> filmes = success.resultado;
        _filmes.addAll(filmes);
        
        if (todosFilmesCarregados) {
          return FilmesEmCartazTodosFilmesCarregadosState(_filmes);
        }

        return FilmesEmCartazSucessoState(_filmes);
      },
      (failure) => FilmesEmCartazFalhaState(),
    ));
  }
}
