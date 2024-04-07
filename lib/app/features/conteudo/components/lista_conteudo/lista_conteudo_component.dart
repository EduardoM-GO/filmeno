import 'package:filmeno/app/features/conteudo/components/lista_conteudo/store/lista_conteudo_store.dart';
import 'package:filmeno/app/features/conteudo/components/widgets/list_view_conteudo_widget.dart';
import 'package:filmeno/app/shared/widgets/tenta_novamente_widget.dart';
import 'package:flutter/material.dart';

class ListaConteudoComponent extends StatefulWidget {
  final String titulo;
  final ListaConteudoUseCase useCase;
  const ListaConteudoComponent({
    super.key,
    required this.titulo,
    required this.useCase,
  });

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
      child = ListViewConteudoWidget(conteudos: state.conteudos);
    } else if (state is ListaConteudoFalhaState) {
      child = TentaNovamenteWidget(onTap: store.buscarConteudos);
    } else {
      child = const Center(child: CircularProgressIndicator());
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: ListTile(
          title: Text(widget.titulo),
          subtitle: SizedBox(height: 200, child: child)),
    );
  }
}
