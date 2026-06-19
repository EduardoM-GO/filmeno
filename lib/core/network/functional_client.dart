import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../shared/exceptions/falha.dart';
import 'api_config.dart';

class FunctionalClient {
  final http.Client _client;

  FunctionalClient(this._client);

  TaskEither<Falha, Map<String, dynamic>> get(String endpoint, {Map<String, String>? params}) {
    return TaskEither.tryCatch(
      () async {
        final uri = Uri.parse('${ApiConfig.baseUrl}$endpoint').replace(queryParameters: params);
        final response = await _client.get(uri, headers: ApiConfig.headers);

        if (response.statusCode == 200) {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } else {
          throw FalhaServidor(statusCode: response.statusCode);
        }
      },
      (error, stackTrace) {
        if (error is Falha) return error;
        return FalhaRede(msg: error.toString(), erro: error, stack: stackTrace);
      },
    );
  }
}
