import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/serie_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

class SerieDatasourceImpl implements SerieDatasource {
  final ClienteHttpService _httpService;
  final Mapper<Serie> _mapper;

  SerieDatasourceImpl(this._httpService, this._mapper);

  @override
  Future<Result<List<Serie>, Falha>> buscarMelhoresAvaliados() async {
    try {
      final response = await _httpService.getList<Serie>(
        url: '${Configuracao.instance.apiUrlBase}/tv/top_rated',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível obter as Séries com as melhores avaliações.',
        exception: exception,
        stack: stack,
        tagMetodo: 'SerieDatasourceImpl-buscarMelhoresAvaliados',
      ));
    }
  }

  @override
  Future<Result<List<Serie>, Falha>> buscarPopular() async {
    try {
      final response = await _httpService.getList<Serie>(
        url: '${Configuracao.instance.apiUrlBase}/tv/popular',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível obter as Séries populares.',
        exception: exception,
        stack: stack,
        tagMetodo: 'SerieDatasourceImpl-buscarPopular',
      ));
    }
  }

  @override
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoHoje() async {
    try {
      final response = await _httpService.getList<Serie>(
        url: '${Configuracao.instance.apiUrlBase}/tv/airing_today',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível obter as Séries que vão ser exibidas hoje.',
        exception: exception,
        stack: stack,
        tagMetodo: 'SerieDatasourceImpl-buscarVaiSerExibidoHoje',
      ));
    }
  }

  @override
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoNaSemana() async {
    try {
      final response = await _httpService.getList<Serie>(
        url: '${Configuracao.instance.apiUrlBase}/tv/on_the_air',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível obter as Séries que vão ser exibidas na semana.',
        exception: exception,
        stack: stack,
        tagMetodo: 'SerieDatasourceImpl-buscarVaiSerExibidoNaSemana',
      ));
    }
  }

  @visibleForTesting
  Map<String, String> get mapHeaders => {
        'Authorization': 'Bearer ${Configuracao.instance.apiKey}',
      };
}
