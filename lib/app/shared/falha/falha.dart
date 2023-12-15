import 'package:equatable/equatable.dart';

sealed class Falha extends Equatable {
  final String mensagemParaUsuario;
  final String tagMetodo;

  const Falha(this.mensagemParaUsuario, this.tagMetodo);

  @override
  List<Object?> get props => [mensagemParaUsuario, tagMetodo];
}

final class Aviso extends Falha {
  const Aviso(super.mensagemParaUsuario, super.tagMetodo);
}

final class Erro extends Falha {
  final Object exception;
  final StackTrace stack;

  const Erro({
    required String mensagemParaUsuario,
    required this.exception,
    required this.stack,
    required String tagMetodo,
  }) : super(mensagemParaUsuario, tagMetodo);

  @override
  List<Object?> get props => [...super.props, exception, stack];
}
