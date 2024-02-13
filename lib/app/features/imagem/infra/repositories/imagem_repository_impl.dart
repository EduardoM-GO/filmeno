import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/features/imagem/infra/datasources/imagem_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class ImagemRepositoryImpl implements ImagemRepository {
  final ImagemCache _cache;
  final ImagemDatasource _datasouce;

  ImagemRepositoryImpl(this._cache, this._datasouce);

  @override
  Future<Result<Unit, Falha>> excluirCacheAntigos() =>
      _cache.excluirCacheAntigos();

  @override
  Future<Result<Imagem, Falha>> obterImagem(String url) =>
      _cache.obterImagem(url);

  @override
  Future<Result<Unit, Falha>> salvar(Imagem imagem) => _cache.salvar(imagem);

  @override
  Future<Result<Uint8List, Falha>> buscarImagemApi(String url) =>
      _datasouce.buscarImagem(url);
}
