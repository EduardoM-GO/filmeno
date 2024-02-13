import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:result_dart/result_dart.dart';

class FilmeDatasourceImpl implements FilmeDatasource {
  final ClienteHttpService _httpService;
  final Mapper<Filme> _mapper;

  FilmeDatasourceImpl(this._httpService, this._mapper);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarEmCartaz(
      {int? proximaPagina}) async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/now_playing',
          mapper: _mapper,
          pagina: proximaPagina);

      final result = ResultadoComMetadados.fromRespostaHttp(response);

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
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarMaisBemAvaliados({int? proximaPagina}) async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/top_rated',
          mapper: _mapper,
          pagina: proximaPagina);

      final result = ResultadoComMetadados.fromRespostaHttp(response);

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
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarPopulares(
      {int? proximaPagina}) async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/popular',
          mapper: _mapper,
          pagina: proximaPagina);

      final result = ResultadoComMetadados.fromRespostaHttp(response);

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
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarProximasEstreias({int? proximaPagina}) async {
    try {
      final response = await _httpService.getList<Filme>(
          url: '${Configuracao.instance.apiUrlBase}/movie/upcoming',
          mapper: _mapper,
          pagina: proximaPagina);

      final result = ResultadoComMetadados.fromRespostaHttp(response);

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
