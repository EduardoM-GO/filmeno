import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/store/store.dart';
import 'package:result_dart/result_dart.dart';

part 'lista_conteudo_state.dart';

typedef ListaConteudoUseCase = Future<Result<List<Conteudo>, Falha>> Function();

class ListaConteudoStore extends Store<ListaConteudoState> {
  final ListaConteudoUseCase _useCase;
  ListaConteudoStore(this._useCase) : super(ListaConteudoInicialState());

  Future<void> buscarConteudos() async {
    emit(ListaConteudoCarregandoState());
    final result = await _useCase();

    emit(
      result.fold(
        ListaConteudoSucessoState.new,
        (_) => ListaConteudoFalhaState(),
      ),
    );
  }
}
