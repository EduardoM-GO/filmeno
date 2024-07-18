import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/conteudo_detalhado.dart';
import 'package:flutter/material.dart';

class ConteudoDetalhadoInheritedWidget extends InheritedWidget {
  final ConteudoDetalhado conteudoDetalhado;

  const ConteudoDetalhadoInheritedWidget({
    super.key,
    required this.conteudoDetalhado,
    required super.child,
  });

  static ConteudoDetalhadoInheritedWidget of(BuildContext context) {
    final result = context
        .dependOnInheritedWidgetOfExactType<ConteudoDetalhadoInheritedWidget>();

    assert(
        result != null, 'No ConteudoDetalhadoInheritedWidget found in context');

    return result!;
  }

  @override
  bool updateShouldNotify(ConteudoDetalhadoInheritedWidget oldWidget) =>
      oldWidget.conteudoDetalhado != conteudoDetalhado;
}
