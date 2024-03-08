import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PercentualNotaConteudoWidget extends StatelessWidget {
  final double avaliacaoUsuario;
  const PercentualNotaConteudoWidget(
      {super.key, required this.avaliacaoUsuario});

  @override
  Widget build(BuildContext context) {
    final String percentual = NumberFormat.decimalPercentPattern(
      locale: 'pt_BR',
      decimalDigits: 0,
    ).format(avaliacaoUsuario);

    return Text(
      percentual,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
