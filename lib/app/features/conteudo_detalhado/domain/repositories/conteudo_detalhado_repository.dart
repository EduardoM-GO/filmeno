import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ConteudoDetalhadoRepository {
  Future<Result<Exception, FilmeDetalhado>> buscarFilmeDetalhado(
    String codigo,
  );
  Future<Result<Exception, SerieDetalhada>> buscarSerieDetalhada(
    String codigo,
  );
}
