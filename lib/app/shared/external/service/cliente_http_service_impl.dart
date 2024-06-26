import 'dart:convert';

import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ClienteHttpServiceImpl implements ClienteHttpService {
  final http.Client _client;
  final Mapper<Metadados> _metadadosMapper;

  ClienteHttpServiceImpl(this._client, this._metadadosMapper);
  @override
  Future<T> get<T extends Object>({
    required String url,
    required Mapper<T> mapper,
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    final Uri uri = getUrl(url, params);

    final response = await _client.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw response;
    }

    final Map<String, dynamic> map =
        jsonDecode(utf8.decode(response.bodyBytes));

    final T retorno = mapper.fromMap(map);
    return retorno;
  }

  @override
  Future<RespostaHttp<List<T>>> getList<T extends Object>({
    required String url,
    required Mapper<T> mapper,
    int? pagina,
    Map<String, String>? headers,
    Map<String, String>? params,
  }) async {
    final Map<String, String> parametros = params ?? {};

    parametros.addAll({'page': '${pagina ?? 1}'});

    final Uri uri = getUrl(url, parametros);

    final response = await _client.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw response;
    }

    final Map<String, dynamic> map =
        jsonDecode(utf8.decode(response.bodyBytes));

    return obterRespostaPorLista(map: map, mapper: mapper);
  }

  @visibleForTesting
  RespostaHttp<List<T>> obterRespostaPorLista<T extends Object>({
    required Map<String, dynamic> map,
    required Mapper<T> mapper,
  }) {
    final List results = map['results'];

    final List<T> retorno =
        results.map((e) => mapper.fromMap(Map.from(e))).toList();

    final Metadados metadadosHttp = _metadadosMapper.fromMap(map);

    final RespostaHttp<List<T>> respostaHttp =
        RespostaHttp<List<T>>(metadadosHttp: metadadosHttp, resultado: retorno);

    return respostaHttp;
  }

  @visibleForTesting
  Uri getUrl(String url, Map<String, String>? params) {
    final Uri uri = Uri.parse(url);
    final Map<String, String> queryParameters = params ?? {};
    queryParameters.addAll({'language': 'pt-BR'});
    return uri.replace(queryParameters: queryParameters);
  }

  @override
  Future<Uint8List> getImagem(String url) async {
    final Uri uri = Uri.parse(url);
    final response = await _client.get(uri);

    if (response.statusCode != 200) {
      throw response;
    }
    return response.bodyBytes;
  }
}
