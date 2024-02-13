import 'dart:typed_data';

import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ImagemDatasource {
  Future<Result<Uint8List, Falha>> buscarImagem(String url);
}
