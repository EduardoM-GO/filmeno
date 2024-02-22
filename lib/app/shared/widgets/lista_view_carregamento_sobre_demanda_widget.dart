import 'package:flutter/material.dart';

class ListaViewCarregamentoSobreDemandaWidget<T extends Object>
    extends StatefulWidget {
  final List<T> dados;
  final bool carregamentoCompleto;
  final Widget Function(T dado) cardDados;
  final VoidCallback carregarMaisDados;
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
  State<ListaViewCarregamentoSobreDemandaWidget> createState() =>
      _ListaViewCarregamentoSobreDemandaWidgetState();
}

class _ListaViewCarregamentoSobreDemandaWidgetState
    extends State<ListaViewCarregamentoSobreDemandaWidget> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        widget.carregarMaisDados();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: const EdgeInsets.all(16),
        scrollDirection: widget.scrollDirection,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        controller: _scrollController,
        itemCount: widget.dados.length + (widget.carregamentoCompleto ? 0 : 1),
        itemBuilder: (context, index) {
          if (index < widget.dados.length) {
            final dado = widget.dados[index];
            return widget.cardDados(dado);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      );
}
