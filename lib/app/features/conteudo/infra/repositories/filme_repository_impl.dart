import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class FilmeRepositoryImpl implements FilmeRepository {
  final FilmeDatasource _datasource;

  FilmeRepositoryImpl(this._datasource);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarEmCartaz(
          {int? proximaPagina}) =>
      _datasource.buscarEmCartaz(proximaPagina: proximaPagina);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarMaisBemAvaliados({int? proximaPagina}) =>
          _datasource.buscarMaisBemAvaliados(proximaPagina: proximaPagina);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarPopulares(
          {int? proximaPagina}) =>
      _datasource.buscarPopulares(proximaPagina: proximaPagina);

  @override
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarProximasEstreias({int? proximaPagina}) =>
          _datasource.buscarProximasEstreias(proximaPagina: proximaPagina);
}
