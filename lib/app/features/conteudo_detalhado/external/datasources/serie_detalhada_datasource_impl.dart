import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/serie_detalhada_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class SerieDetalhadaDatasourceImpl implements SerieDetalhadaDatasource {
  @override
  Future<Result<Falha, SerieDetalhada>> get(String codigo) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
