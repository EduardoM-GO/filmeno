import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class FilmeRepositoryImpl implements FilmeRepository {
  final FilmeDatasource _datasource;

  FilmeRepositoryImpl(this._datasource);

  @override
  Future<Result<List<Filme>, Falha>> buscarEmCartaz() =>
      _datasource.buscarEmCartaz();

  @override
  Future<Result<List<Filme>, Falha>> buscarMelhoresAvalidados() =>
      _datasource.buscarMelhoresAvalidados();

  @override
  Future<Result<List<Filme>, Falha>> buscarPopulares() =>
      _datasource.buscarPopulares();

  @override
  Future<Result<List<Filme>, Falha>> buscarProximasEstreias() =>
      _datasource.buscarProximasEstreias();
}
