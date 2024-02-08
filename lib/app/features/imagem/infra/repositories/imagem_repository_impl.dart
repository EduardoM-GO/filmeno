import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class ImagemRepositoryImpl implements ImagemRepository {
  final ImagemCache _cache;

  ImagemRepositoryImpl(this._cache);

  @override
  Future<Result<Unit, Falha>> excluirCacheAntigos() =>
      _cache.excluirCacheAntigos();

  @override
  Future<Result<Imagem, Falha>> obterImagem(String url) =>
      _cache.obterImagem(url);

  @override
  Future<Result<Unit, Falha>> salvar(Imagem imagem) => _cache.salvar(imagem);
}
