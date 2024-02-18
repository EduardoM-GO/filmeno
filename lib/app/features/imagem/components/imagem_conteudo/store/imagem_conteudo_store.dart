import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:filmeno/app/shared/store/store.dart';

part 'imagem_conteudo_state.dart';

class ImagemConteudoStore extends Store<ImagemConteudoState> {
  final ObterImagemUseCase _useCase;

  ImagemConteudoStore(this._useCase) : super(ImagemConteudoInicialState());

  Future<void> carregaImagem(Conteudo conteudo) async {
    emit(ImagemConteudoCarregandoState());
    final result = await _useCase(conteudo.urlCapa);

    result.fold(
      (success) => emit(ImagemConteudoSucessoState(success)),
      (failure) => emit(ImagemConteudoFalhaState()),
    );
  }
}
