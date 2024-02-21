import 'package:equatable/equatable.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';

class RespostaHttp<T extends Object> extends Equatable {
  final Metadados metadadosHttp;
  final T resultado;

  const RespostaHttp({
    required this.metadadosHttp,
    required this.resultado,
  });

  @override
  List<Object?> get props => [metadadosHttp, resultado];
}
