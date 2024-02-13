import 'dart:typed_data';

import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';

abstract interface class ClienteHttpService {
  Future<T> get<T extends Object>(
      {required String url,
      required Mapper<T> mapper,
      Map<String, String>? headers});

  Future<RespostaHttp<List<T>>> getList<T extends Object>(
      {required String url,
      required Mapper<T> mapper,
      int? pagina,
      Map<String, String>? headers});

  Future<Uint8List> getImagem(String url);
}
