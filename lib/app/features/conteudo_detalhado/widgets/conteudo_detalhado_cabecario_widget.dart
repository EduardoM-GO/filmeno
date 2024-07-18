import 'package:filmeno/app/features/conteudo_detalhado/widgets/botao_icone_favorito_widget.dart';
import 'package:filmeno/app/features/conteudo_detalhado/widgets/conteudo_detalhado_inherited_widget.dart';
import 'package:flutter/material.dart';

class ConteudoDetalhadoCabecarioWidget extends StatelessWidget {
  const ConteudoDetalhadoCabecarioWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final conteudo =
        ConteudoDetalhadoInheritedWidget.of(context).conteudoDetalhado;
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {},
        ),
        BotaoIconeFavoritoWidget(
          favoritado: conteudo.favorito,
          onChanged: (value) {
            return null;
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Image.memory(
          conteudo.imagemCapa!.imagem,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
