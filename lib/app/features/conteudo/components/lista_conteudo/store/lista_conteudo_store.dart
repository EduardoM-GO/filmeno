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
  bool _emExecucao;
  ListaConteudoStore(this._useCase)
      : _emExecucao = false,
        super(ListaConteudoInicialState());

  final List<Conteudo> _conteudos = [];

  int? _proximaPagina;
  bool _todosConteudosCarregados = false;

  Future<void> buscarConteudos() async {
    if (_emExecucao) return;
    _emExecucao = true;
    emit(ListaConteudoCarregandoState());
    final result = await _useCase();

    result.fold(
      sucesso,
      (failure) => emit(ListaConteudoFalhaState()),
    );
    _emExecucao = false;
  }

  Future<void> buscarMaisConteudos() async {
    if (_emExecucao) return;
    _emExecucao = true;
    if (_todosConteudosCarregados) {
      emit(ListaConteudoSucessoState(
          conteudos: _conteudos, carregamentoCompleto: true));
      return;
    }
    final result = await _useCase(proximaPagina: _proximaPagina);

    result.onSuccess(sucesso);
    _emExecucao = false;
  }

  void sucesso(ResultadoComMetadados<List<Conteudo>> success) {
    final Metadados metadados = success.metadados;
    _proximaPagina = metadados.proximaPagina;
    _todosConteudosCarregados = !metadados.temProximaPagina;

    final List<Conteudo> conteudos = success.resultado;
    _conteudos.addAll(conteudos);

    if (_todosConteudosCarregados) {
      emit(ListaConteudoSucessoState(
          conteudos: _conteudos, carregamentoCompleto: true));
      return;
    }

    emit(ListaConteudoSucessoState(
      conteudos: _conteudos,
      carregamentoCompleto: _conteudos.isEmpty,
    ));
  }
}
