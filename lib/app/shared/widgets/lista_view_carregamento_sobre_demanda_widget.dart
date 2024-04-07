import 'dart:async';

import 'package:filmeno/app/shared/domain/entities/lista_animada.dart';
import 'package:flutter/material.dart';

class ListaViewCarregamentoSobreDemandaWidget<T extends Object>
    extends StatefulWidget {
  final List<T> dados;
  final bool carregamentoCompleto;
  final Widget Function(T dado) cardDados;
  final FutureOr<void> Function() carregarMaisDados;
  final Axis scrollDirection;
  const ListaViewCarregamentoSobreDemandaWidget({
    super.key,
    required this.dados,
    required this.carregamentoCompleto,
    required this.cardDados,
    required this.carregarMaisDados,
    required this.scrollDirection,
  });

  @override
  State<ListaViewCarregamentoSobreDemandaWidget<T>> createState() =>
      _ListaViewCarregamentoSobreDemandaWidgetState<T>();
}

class _ListaViewCarregamentoSobreDemandaWidgetState<T extends Object>
    extends State<ListaViewCarregamentoSobreDemandaWidget<T>> {
  late final ScrollController _scrollController;
  late final GlobalKey<AnimatedListState> listKey;
  late ListaAnimada<T> lista;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    _scrollController = ScrollController();
    _scrollController.addListener(_carregarMaisDados);
    listKey = GlobalKey<AnimatedListState>();
    lista = ListaAnimada<T>(listKey: listKey, items: widget.dados);
  }

  @override
  void didUpdateWidget(
      covariant ListaViewCarregamentoSobreDemandaWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dados != widget.dados) {
      lista.adicionarNaLista(widget.dados);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _carregarMaisDados() async {
    ///Evitar que usuario solicite mais de uma vez o carregamento de dados ao mesmo tempo
    if (isLoading) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      isLoading = true;
      await widget.carregarMaisDados();
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) => AnimatedList(
        key: listKey,
        padding: const EdgeInsets.all(16),
        scrollDirection: widget.scrollDirection,
        controller: _scrollController,
        initialItemCount:
            widget.carregamentoCompleto ? lista.length : lista.length + 1,
        itemBuilder: (context, index, animation) {
          if (index < widget.dados.length) {
            final T dado = widget.dados[index];
            return SizeTransition(
                sizeFactor: animation, child: widget.cardDados(dado));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
