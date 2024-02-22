import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/store/store.dart';
import 'package:result_dart/result_dart.dart';

part 'lista_conteudo_state.dart';

typedef ListaConteudoUseCase
    = Future<Result<ResultadoComMetadados<List<Conteudo>>, Falha>> Function(
        {int? proximaPagina});

class ListaConteudoStore extends Store<ListaConteudoState> {
  final ListaConteudoUseCase _useCase;

  ListaConteudoStore(this._useCase) : super(ListaConteudoInicialState());

  final List<Conteudo> _conteudos = [];

  int? _proximaPagina;
  bool _todosConteudosCarregados = false;

  Future<void> buscarConteudos() async {
    if (_todosConteudosCarregados) {
      emit(ListaConteudoSucessoState(
          conteudos: _conteudos, carregamentoCompleto: true));
      return;
    }

    emit(ListaConteudoCarregandoState());
    final result = await _useCase(proximaPagina: _proximaPagina);

    emit(result.fold(
      (success) {
        final Metadados metadados = success.metadados;
        _proximaPagina = metadados.proximaPagina;
        _todosConteudosCarregados = !metadados.temProximaPagina;

        final List<Conteudo> conteudos = success.resultado;
        _conteudos.addAll(conteudos);

        if (_todosConteudosCarregados) {
          return ListaConteudoSucessoState(
              conteudos: _conteudos, carregamentoCompleto: true);
        }

        return ListaConteudoSucessoState(
          conteudos: _conteudos,
          carregamentoCompleto: _conteudos.isEmpty,
        );
      },
      (failure) => ListaConteudoFalhaState(),
    ));
  }
}
