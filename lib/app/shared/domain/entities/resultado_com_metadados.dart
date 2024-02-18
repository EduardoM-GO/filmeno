import 'package:equatable/equatable.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';

class ResultadoComMetadados<T extends Object> extends Equatable {
  final T resultado;
  final MetadadosHttp metadados;

  const ResultadoComMetadados({
    required this.metadados,
    required this.resultado,
  });

  factory ResultadoComMetadados.fromRespostaHttp(
    RespostaHttp<T> respostaHttp,
  ) =>
      ResultadoComMetadados(
        metadados: respostaHttp.metadadosHttp,
        resultado: respostaHttp.resultado,
      );

  @override
  List<Object?> get props => [resultado, metadados];
}
