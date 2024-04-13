import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/features/imagem/infra/datasources/imagem_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

class ImagemRepositoryImpl implements ImagemRepository {
  final ImagemCache _cache;
  final ImagemDatasource _datasource;

  ImagemRepositoryImpl(this._cache, this._datasource);

  @override
  Future<Result<Unit, Falha>> excluirCacheAntigos() =>
      _cache.excluirCacheAntigos();

  @override
  Future<Result<Imagem, Falha>> obterImagem(String url) async {
    final resultImagemCache = await _cache.obterImagem(url);
    if (resultImagemCache.isError()) {
      return Failure(resultImagemCache.exceptionOrNull()!);
    }

    final Imagem imagemCache = resultImagemCache.getOrDefault(Imagem.empty());

    if (imagemCache.isNotEmpty) {
      return Success(imagemCache);
    }

    final resultImagemApi = await _datasource.buscarImagem(url);

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
    final result = await _cache.salvar(imagem);

    /// Não retorna mensagem de erro do salvamento, já que o usuário não precisa ser notificado
    /// sobre possíveis falhas ao salvar em cache. Caso a imagem não seja encontrada no cache,
    /// a rotina realizará uma nova consulta na API.
    return result.fold(
      (success) => imagem,
      (failure) => imagem,
    );
  }
}
