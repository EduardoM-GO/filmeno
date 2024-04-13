import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

abstract base class ObterImagemConteudosUseCase<T extends Conteudo> {
  final ImagemRepository imagemRepository;

  ObterImagemConteudosUseCase(this.imagemRepository);

  @protected
  @visibleForTesting
  Future<Result<List<T>, Falha>> getImagemDosConteudos(
      List<T> conteudos) async {
    final List<T> conteudosComImagem = [];
    for (final conteudo in conteudos) {
      final resultImagem = await imagemRepository.obterImagem(conteudo.urlCapa);
      if (resultImagem.isError()) {
        return Failure(resultImagem.exceptionOrNull()!);
      }
      final conteudoComImagem =
          conteudo.copyWith(imagemCapa: resultImagem.getOrNull()) as T;

      conteudosComImagem.add(conteudoComImagem);
    }
    return Success(conteudosComImagem);
  }
}
