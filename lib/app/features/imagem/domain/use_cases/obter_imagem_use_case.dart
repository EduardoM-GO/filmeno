import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ObterImagemUseCase {
  Future<Result<Imagem, Falha>> call(String url);
}

class ObterImagemUseCaseImpl implements ObterImagemUseCase {
  final ImagemRepository _repository;

  ObterImagemUseCaseImpl(this._repository);

  @override
  Future<Result<Imagem, Falha>> call(String url) async {
    final resultImagemCache = await _repository.obterImagem(url);

    if (resultImagemCache.isError()) {
      return Failure(resultImagemCache.exceptionOrNull()!);
    }

    final Imagem imagemCache = resultImagemCache.getOrDefault(Imagem.empty());

    if (imagemCache.isNotEmpty) {
      return Success(imagemCache);
    }

    final resultImagemApi = await _repository.buscarImagemApi(url);

    if (resultImagemApi.isError()) {
      return Failure(resultImagemApi.exceptionOrNull()!);
    }

    final Imagem imagemApi = Imagem(
      dataCriacao: DateTime.now(),
      url: url,
      imagem: resultImagemApi.getOrDefault(Uint8List(0)),
    );

    final resultImagem = await salvarEmCache(imagemApi);

    return Success(resultImagem);
  }

  @visibleForTesting
  Future<Imagem> salvarEmCache(Imagem imagem) async {
    final result = await _repository.salvar(imagem);

    /// Não retorna mensagem de erro do salvamento, já que o usuário não precisa ser notificado
    /// sobre possíveis falhas ao salvar em cache. Caso a imagem não seja encontrada no cache,
    /// a rotina realizará uma nova consulta na API.
    return result.fold(
      (success) => imagem,
      (failure) => imagem,
    );
  }
}
