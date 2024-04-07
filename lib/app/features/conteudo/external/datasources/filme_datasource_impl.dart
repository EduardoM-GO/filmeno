import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter/foundation.dart';
import 'package:result_dart/result_dart.dart';

class FilmeDatasourceImpl implements FilmeDatasource {
  final ClienteHttpService _httpService;
  final Mapper<Filme> _mapper;

  FilmeDatasourceImpl(this._httpService, this._mapper);
  @visibleForTesting
  Map<String, String> get mapHeaders => {
        'Authorization': 'Bearer ${Configuracao.instance.apiKey}',
      };

  @override
  Future<Result<List<Filme>, Falha>> buscarEmCartaz() async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/now_playing',
          headers: mapHeaders,
          mapper: _mapper);

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível recuperar os filmes em exibição.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDatasourceImpl-buscarEmCartaz',
      ));
    }
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarMelhoresAvalidados() async {
    try {
      final response = await _httpService.getList<Filme>(
        url: '${Configuracao.instance.apiUrlBase}/movie/top_rated',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível obter os filmes com as melhores avaliações.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDatasourceImpl-buscarMaisBemAvaliados',
      ));
    }
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarPopulares() async {
    try {
      final response = await _httpService.getList<Filme>(
        url: '${Configuracao.instance.apiUrlBase}/movie/popular',
        headers: mapHeaders,
        mapper: _mapper,
      );

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario: 'Não foi possível obter os filmes populares.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDatasourceImpl-buscarPopulares',
      ));
    }
  }

  @override
  Future<Result<List<Filme>, Falha>> buscarProximasEstreias() async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/upcoming',
          headers: mapHeaders,
          mapper: _mapper);

      final result = response.resultado;

      return Success(result);
    } catch (exception, stack) {
      return Failure(Erro(
        mensagemParaUsuario:
            'Não foi possível obter os filmes das próximas estreias.',
        exception: exception,
        stack: stack,
        tagMetodo: 'FilmeDatasourceImpl-buscarProximasEstreias',
      ));
    }
  }
}
