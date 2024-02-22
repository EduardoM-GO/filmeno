import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/percentual_nota_conteudo_widget.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter/material.dart';

class ImagemWidget extends StatelessWidget {
  final Imagem imagem;
  final double avaliacaoUsuario;
  const ImagemWidget({
    super.key,
    required this.imagem,
    required this.avaliacaoUsuario,
  });

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (imagem.isNotEmpty) {
      child = Stack(alignment: Alignment.bottomRight, children: [
        Image.memory(
          imagem.imagem,
          fit: BoxFit.cover,
        ),
        PercentualNotaConteudoWidget(avaliacaoUsuario: avaliacaoUsuario)
      ]);
    }
    child ??= const Placeholder();

    return AnimatedSwitcher(
      duration: Configuracao.instance.duracaoAnimacao,
      child: child,
    );
  }
}
