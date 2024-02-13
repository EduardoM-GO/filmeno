import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';

class ResultadoComMetadados<T extends Object> extends MetadadosHttp {
  final T retorno;

  const ResultadoComMetadados({
    required super.paginaAtual,
    required super.quantidadePaginaTotal,
    required this.retorno,
  });

  factory ResultadoComMetadados.fromRespostaHttp(
    RespostaHttp<T> respostaHttp,
  ) =>
      ResultadoComMetadados(
        paginaAtual: respostaHttp.metadadosHttp.paginaAtual,
        quantidadePaginaTotal: respostaHttp.metadadosHttp.quantidadePaginaTotal,
        retorno: respostaHttp.retorno,
      );

  @override
  List<Object?> get props => [...super.props, retorno];
}
