import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/infra/datasources/imagem_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:result_dart/result_dart.dart';

class ImagemDatasourceImpl implements ImagemDatasource {
  final ClienteHttpService _httpService;

  ImagemDatasourceImpl(this._httpService);
  @override
  Future<Result<Uint8List, Falha>> buscarImagem(String url) async {
    try {
      final response = await _httpService
          .getImagem('${Configuracao.instance.imagemUrlBase}$url');

      return Result.success(response);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível obter a imagem',
        exception: exception,
        stack: stack,
        tagMetodo: 'ImagemDatasouceImpl-buscarImagem',
      ));
    }
  }
}
