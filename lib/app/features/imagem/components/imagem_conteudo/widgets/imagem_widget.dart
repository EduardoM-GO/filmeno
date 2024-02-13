import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:flutter/material.dart';

class ImagemWidget extends StatelessWidget {
  final Imagem imagem;
  const ImagemWidget({
    super.key,
    required this.imagem,
  });

  @override
  Widget build(BuildContext context) {
    Widget? child;
    if (imagem.isNotEmpty) {
      child = Image.memory(
        imagem.imagem,
        fit: BoxFit.cover,
      );
    }
    child ??= const Placeholder();

    return AnimatedSwitcher(
      duration: Configuracao.instance.duracaoAnimacao,
      child: child,
    );
  }
}
