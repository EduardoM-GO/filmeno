import 'package:equatable/equatable.dart';

enum TipoDeAcesso { comprar, alugar, assinatura }

class PlataformaStreaming extends Equatable {
  final String codigo;
  final String nome;
  final String urlLogo;
  final String linkParaConteudo;
  final TipoDeAcesso tipoDeAcesso;

  const PlataformaStreaming({
    required this.codigo,
    required this.nome,
    required this.urlLogo,
    required this.linkParaConteudo,
    required this.tipoDeAcesso,
  });

  @override
  List<Object> get props => [
        codigo,
        nome,
        urlLogo,
        linkParaConteudo,
        tipoDeAcesso,
      ];
}
