part of 'imagem_conteudo_store.dart';

sealed class ImagemConteudoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class ImagemConteudoInicialState extends ImagemConteudoState {}

final class ImagemConteudoCarregandoState extends ImagemConteudoState {}

final class ImagemConteudoSucessoState extends ImagemConteudoState {
  final Imagem imagem;

  ImagemConteudoSucessoState(this.imagem);

  @override
  List<Object?> get props => [imagem];
}

final class ImagemConteudoFalhaState extends ImagemConteudoState {}
