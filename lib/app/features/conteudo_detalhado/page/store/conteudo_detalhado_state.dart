part of 'conteudo_detalhado_store.dart';

sealed class ConteudoDetalhadoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ConteudoDetalhadoInicialState extends ConteudoDetalhadoState {}

final class ConteudoDetalhadoCarregandoState extends ConteudoDetalhadoState {}

final class ConteudoDetalhadoSucessoState extends ConteudoDetalhadoState {
  final ConteudoDetalhado conteudoDetalhado;

  ConteudoDetalhadoSucessoState(this.conteudoDetalhado);

  @override
  List<Object?> get props => [conteudoDetalhado];
}

final class ConteudoDetalhadoFalhaState extends ConteudoDetalhadoState {
  final Falha erro;

  ConteudoDetalhadoFalhaState(this.erro);

  @override
  List<Object?> get props => [erro];
}
