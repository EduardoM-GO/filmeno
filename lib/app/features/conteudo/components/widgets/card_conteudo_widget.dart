import 'package:filmeno/app/features/conteudo/components/widgets/percentual_nota_conteudo_widget.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter/material.dart';

class CardConteudoWidget extends StatelessWidget {
  final Conteudo conteudo;
  const CardConteudoWidget({super.key, required this.conteudo});

  @override
  Widget build(BuildContext context) {
    Widget? child;

    if (conteudo.imagemCapa?.isNotEmpty ?? false) {
      child = Stack(alignment: Alignment.bottomRight, children: [
        Image.memory(
          conteudo.imagemCapa!.imagem,
          fit: BoxFit.cover,
        ),
        PercentualNotaConteudoWidget(
            avaliacaoUsuario: conteudo.avaliacaoUsuario)
      ]);
    }
    child ??= const Placeholder();

    return AnimatedSwitcher(
      duration: Configuracao.instance.duracaoAnimacao,
      child: SizedBox(height: 250, width: 150, child: child),
    );
  }
}
