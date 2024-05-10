import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:flutter/material.dart';

class ConteudoDetalhadoPage extends StatelessWidget {
  final Conteudo conteudo;

  const ConteudoDetalhadoPage({super.key, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}
