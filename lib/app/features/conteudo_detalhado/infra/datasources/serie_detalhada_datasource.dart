import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class SerieDetalhadaDatasource {
  Future<Result<SerieDetalhada, Falha>> get(String codigo);
}
