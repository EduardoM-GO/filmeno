import 'package:equatable/equatable.dart';

class Metadados extends Equatable {
  final int paginaAtual;
  final int quantidadePaginaTotal;

  const Metadados(
      {required this.paginaAtual, required this.quantidadePaginaTotal});

  int get proximaPagina => paginaAtual + 1;

  bool get temProximaPagina => paginaAtual < quantidadePaginaTotal;

  @override
  List<Object?> get props => [paginaAtual, quantidadePaginaTotal];
}
