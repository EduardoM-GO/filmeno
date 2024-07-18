import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/repositories/conteudo_detalhado_repository.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/filme_detalhado_datasource.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/serie_detalhada_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class ConteudoDetalhadoRepositoryImpl implements ConteudoDetalhadoRepository {
  final FilmeDetalhadoDatasource _filmeDetalhadoDatasource;
  final SerieDetalhadaDatasource _serieDetalhadaDatasource;

  ConteudoDetalhadoRepositoryImpl(
      this._filmeDetalhadoDatasource, this._serieDetalhadaDatasource);

  @override
  Future<Result<FilmeDetalhado, Falha>> buscarFilmeDetalhado(
    String codigo,
  ) =>
      _filmeDetalhadoDatasource.get(codigo);

  @override
  Future<Result<SerieDetalhada, Falha>> buscarSerieDetalhada(
    String codigo,
  ) =>
      _serieDetalhadaDatasource.get(codigo);
}
