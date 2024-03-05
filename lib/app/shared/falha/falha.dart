import 'dart:developer';

import 'package:equatable/equatable.dart';

sealed class Falha extends Equatable {
  final String mensagemParaUsuario;
  final String tagMetodo;

  Falha({required this.mensagemParaUsuario, required this.tagMetodo}) {
    log(mensagemParaUsuario, name: tagMetodo);
  }

  @override
  List<Object?> get props => [mensagemParaUsuario, tagMetodo];
}

final class Aviso extends Falha {
  Aviso({
    required super.mensagemParaUsuario,
    required super.tagMetodo,
  });
}

final class Erro extends Falha {
  final Object exception;
  final StackTrace stack;

  Erro({
    required super.mensagemParaUsuario,
    required this.exception,
    required this.stack,
    required super.tagMetodo,
  }) {
    log(mensagemParaUsuario,
        error: exception, stackTrace: stack, name: tagMetodo);
  }

  @override
  List<Object?> get props => [...super.props, exception, stack];
}
