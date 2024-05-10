import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class FilmeDetalhadoDatasource {
  Future<Result<Falha, FilmeDetalhado>> get(String codigo);
}
