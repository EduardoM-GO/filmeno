import 'package:flutter/material.dart';

class ListaAnimada<T> {
  final GlobalKey<AnimatedListState> listKey;
  final List<T> _items;

  ListaAnimada({required this.listKey, required List<T> items})
      : _items = items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void adicionarNaLista(List<T> itens) {
    if (length >= itens.length) {
      return;
    }
    final itensParaAdicionar = itens.sublist(length - 1);
    for (final item in itensParaAdicionar) {
      final int index = _items.length;
      _items.insert(index, item);
      _animatedList?.insertItem(index);
    }
  }

  int get length => _items.length;

  T operator [](int index) => _items[index];
}
