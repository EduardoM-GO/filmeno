import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class FilmeDatasource {
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarPopulares(
      {int? proximaPagina});
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>> buscarEmCartaz(
      {int? proximaPagina});
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarProximasEstreias({int? proximaPagina});
  Future<Result<ResultadoComMetadados<List<Filme>>, Falha>>
      buscarMelhoresAvalidados({int? proximaPagina});
}
