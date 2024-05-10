import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/repositories/conteudo_detalhado_repository.dart';
import 'package:result_dart/result_dart.dart';

class ConteudoDetalhadoRepositoryImpl implements ConteudoDetalhadoRepository {
  @override
  Future<Result<Exception, FilmeDetalhado>> buscarFilmeDetalhado(
    String codigo,
  ) {
    // TODO: implement buscarFilmeDetalhado
    throw UnimplementedError();
  }

  @override
  Future<Result<Exception, SerieDetalhada>> buscarSerieDetalhada(
    String codigo,
  ) {
    // TODO: implement buscarSerieDetalhada
    throw UnimplementedError();
  }
}
