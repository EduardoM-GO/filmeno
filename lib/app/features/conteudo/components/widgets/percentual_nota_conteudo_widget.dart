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
    final ThemeData theme = Theme.of(context);

    return Container(
      width: 36,
      height: 36,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      margin: const EdgeInsets.all(4),
      child: Text(
        percentual,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
