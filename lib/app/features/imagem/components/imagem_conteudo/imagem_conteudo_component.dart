import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/store/imagem_conteudo_store.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/imagem_widget.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:filmeno/app/shared/widgets/tenta_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ImagemConteudoComponent extends StatefulWidget {
  final Conteudo conteudo;
  const ImagemConteudoComponent({super.key, required this.conteudo});

  @override
  State<ImagemConteudoComponent> createState() =>
      _ImagemConteudoComponentState();
}

class _ImagemConteudoComponentState extends State<ImagemConteudoComponent> {
  late final ImagemConteudoStore store;

  @override
  void initState() {
    super.initState();
    store = ImagemConteudoStore(GetIt.I.get<ObterImagemUseCase>());
    store.carregaImagem(widget.conteudo);
    store.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = store.state;
    return switch (state) {
      ImagemConteudoSucessoState() => ImagemWidget(imagem: state.imagem),
      ImagemConteudoFalhaState() =>
        TentaNovamenteWidget(onTap: () => store.carregaImagem(widget.conteudo)),
      _ => const CircularProgressIndicator()
    };
  }
}
