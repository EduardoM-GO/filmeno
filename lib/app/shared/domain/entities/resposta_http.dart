import 'package:equatable/equatable.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';

class RespostaHttp<T extends Object> extends Equatable {
  final MetadadosHttp metadadosHttp;
  final T resultado;

  const RespostaHttp({
    required this.metadadosHttp,
    required this.resultado,
  });

  @override
  List<Object?> get props => [metadadosHttp, resultado];
}
