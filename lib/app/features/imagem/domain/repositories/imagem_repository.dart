import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ImagemRepository {
  Future<Result<Unit, Falha>> salvar(Imagem imagem);

  Future<Result<Imagem, Falha>> obterImagem(String url);

  Future<Result<Unit, Falha>> excluirCacheAntigos();

  Future<Result<Uint8List, Falha>> buscarImagemApi(String url);
}
