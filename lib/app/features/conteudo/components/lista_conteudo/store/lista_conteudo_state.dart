part of 'lista_conteudo_store.dart';

sealed class ListaConteudoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ListaConteudoInicialState extends ListaConteudoState {}

final class ListaConteudoCarregandoState extends ListaConteudoState {}

final class ListaConteudoSucessoState extends ListaConteudoState {
  final List<Conteudo> conteudos;
  final bool carregamentoCompleto;

  ListaConteudoSucessoState(
      {required this.conteudos, required this.carregamentoCompleto});

  @override
  List<Object?> get props => [conteudos, carregamentoCompleto];
}

final class ListaConteudoFalhaState extends ListaConteudoState {}
