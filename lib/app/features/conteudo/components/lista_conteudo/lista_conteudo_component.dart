import 'package:filmeno/app/features/conteudo/components/lista_conteudo/store/lista_conteudo_store.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/imagem_conteudo_component.dart';
import 'package:filmeno/app/shared/widgets/lista_view_carregamento_sobre_demanda_widget.dart';
import 'package:filmeno/app/shared/widgets/tenta_novamente_widget.dart';
import 'package:flutter/material.dart';

class ListaConteudoComponent extends StatefulWidget {
  final ListaConteudoUseCase useCase;
  const ListaConteudoComponent({super.key, required this.useCase});

  @override
  State<ListaConteudoComponent> createState() => _ListaConteudoComponentState();
}

class _ListaConteudoComponentState extends State<ListaConteudoComponent> {
  late final ListaConteudoStore store;

  @override
  void initState() {
    super.initState();
    store = ListaConteudoStore(widget.useCase);
    store.addListener(() {
      setState(() {});
    });
    store.buscarConteudos();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = store.state;
    Widget? child;
    if (state is ListaConteudoSucessoState) {
      child = ListaViewCarregamentoSobreDemandaWidget<Conteudo>(
        scrollDirection: Axis.horizontal,
        dados: state.conteudos,
        carregamentoCompleto: state.carregamentoCompleto,
        cardDados: (conteudo) => ImagemConteudoComponent(conteudo: conteudo),
        carregarMaisDados: store.buscarConteudos,
      );
    } else if (state is ListaConteudoFalhaState) {
      child = TentaNovamenteWidget(onTap: store.buscarConteudos);
    } else {
      child = const CircularProgressIndicator();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
