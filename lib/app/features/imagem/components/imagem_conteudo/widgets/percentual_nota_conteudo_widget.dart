import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late double avaliacaoAnterior;

  @override
  void initState() {
    super.initState();
    avaliacaoAnterior = 0;
  }

  @override
  void didUpdateWidget(covariant PercentualNotaConteudoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.avaliacaoUsuario != widget.avaliacaoUsuario) {
      avaliacaoAnterior = oldWidget.avaliacaoUsuario;
    }
  }

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween<double>(
            begin: avaliacaoAnterior, end: widget.avaliacaoUsuario),
        duration: Configuracao.instance.duracaoAnimacao,
        builder: (context, value, child) {
          final String percentual = NumberFormat.decimalPercentPattern(
            locale: 'pt_BR',
            decimalDigits: 0,
          ).format(value / 100);

          return Text(
            percentual,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      );
}
