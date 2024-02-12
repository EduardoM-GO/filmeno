import 'package:equatable/equatable.dart';

class MetadadosHttp extends Equatable {
  final int paginaAtual;
  final int quantidadePaginaTotal;

  const MetadadosHttp(
      {required this.paginaAtual, required this.quantidadePaginaTotal});

  @override
  List<Object?> get props => [paginaAtual, quantidadePaginaTotal];
}
