import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo_detalhado/widgets/conteudo_detalhado_inherited_widget.dart';
import 'package:flutter/material.dart';

class ConteudoDetalhadoPage extends StatelessWidget {
  final Conteudo conteudo;

  const ConteudoDetalhadoPage({super.key, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return ConteudoDetalhadoInheritedWidget(
      conteudoDetalhado: conteudo,
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
