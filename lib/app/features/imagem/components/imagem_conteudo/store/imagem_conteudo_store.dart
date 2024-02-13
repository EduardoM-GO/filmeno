import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:flutter/foundation.dart';

part 'imagem_conteudo_state.dart';

class ImagemConteudoStore extends ChangeNotifier {
  final ObterImagemUseCase _useCase;

  ImagemConteudoState state;
  ImagemConteudoStore(this._useCase) : state = ImagemConteudoInicialState();

  Future<void> carregaImagem(Conteudo conteudo) async {
    _addState(ImagemConteudoCarregandoState());
    final result = await _useCase(conteudo.urlCapa);

    result.fold(
      (success) => _addState(ImagemConteudoSucessoState(success)),
      (failure) => _addState(ImagemConteudoFalhaState()),
    );
  }

  void _addState(ImagemConteudoState state) {
    this.state = state;
    notifyListeners();
  }
}
