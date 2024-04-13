import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:flutter/material.dart';

class PercentualNotaConteudoWidget extends StatelessWidget {
  final Conteudo conteudo;
  const PercentualNotaConteudoWidget({super.key, required this.conteudo});

  @override
  Widget build(BuildContext context) {
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
        conteudo.avaliacaoUsuarioFormatada,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
