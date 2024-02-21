import 'package:flutter/material.dart';

class PercentualNotaConteudoWidget extends StatefulWidget {
  final double avaliacaoUsuario;

  const PercentualNotaConteudoWidget(
      {super.key, required this.avaliacaoUsuario});

  @override
  State<PercentualNotaConteudoWidget> createState() =>
      _PercentualNotaConteudoWidgetState();
}

class _PercentualNotaConteudoWidgetState
    extends State<PercentualNotaConteudoWidget> {
  //TODO: implementar PercentualNotaConteudoWidget
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
