import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/imagem_conteudo_component.dart';
import 'package:filmeno/app/shared/widgets/sem_registro_widget.dart';
import 'package:flutter/material.dart';

class ListViewConteudoWidget extends StatelessWidget {
  final List<Conteudo> conteudos;
  const ListViewConteudoWidget({super.key, required this.conteudos});

  @override
  Widget build(BuildContext context) {
    if (conteudos.isEmpty) {
      return const SemRegistroWidget();
    }

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: conteudos.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) {
        final conteudo = conteudos[index];
        return ImagemConteudoComponent(conteudo: conteudo);
      },
    );
  }
}
