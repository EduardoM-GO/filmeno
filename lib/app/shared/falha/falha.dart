import 'package:equatable/equatable.dart';

sealed class Falha extends Equatable {
  final String mensagemParaUsuario;
  final String tagMetodo;

  const Falha({required this.mensagemParaUsuario, required this.tagMetodo});

  @override
  List<Object?> get props => [mensagemParaUsuario, tagMetodo];
}

final class Aviso extends Falha {
  const Aviso({
    required super.mensagemParaUsuario,
    required super.tagMetodo,
  });
}

final class Erro extends Falha {
  final Object exception;
  final StackTrace stack;

  const Erro({
    required super.mensagemParaUsuario,
    required this.exception,
    required this.stack,
    required super.tagMetodo,
  });

  @override
  List<Object?> get props => [...super.props, exception, stack];
}
