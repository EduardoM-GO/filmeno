import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/serie_repository.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/serie_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class SerieRepositoryImpl implements SerieRepository {
  final SerieDatasource _datasource;

  SerieRepositoryImpl(this._datasource);

  @override
  Future<Result<List<Serie>, Falha>> buscarMelhoresAvaliados() =>
      _datasource.buscarMelhoresAvaliados();

  @override
  Future<Result<List<Serie>, Falha>> buscarPopular() =>
      _datasource.buscarPopular();

  @override
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoHoje() =>
      _datasource.buscarVaiSerExibidoHoje();

  @override
  Future<Result<List<Serie>, Falha>> buscarVaiSerExibidoNaSemana() =>
      _datasource.buscarVaiSerExibidoNaSemana();
}
