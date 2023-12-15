import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract class ImagemCache {
  Future<Result<Unit, Falha>> salvar(Imagem imagem);

  Future<Result<Imagem, Falha>> obterImagem(String url);

  Future<Result<Unit, Falha>> excluirCacheAntigos();
}
