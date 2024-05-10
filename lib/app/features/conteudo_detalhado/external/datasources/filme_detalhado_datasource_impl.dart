import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/infra/datasources/filme_detalhado_datasource.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:result_dart/result_dart.dart';

class FilmeDetalhadoDatasourceImpl implements FilmeDetalhadoDatasource {
  @override
  Future<Result<Falha, FilmeDetalhado>> get(String codigo) {
    // TODO: implement get
    throw UnimplementedError();
  }
}
