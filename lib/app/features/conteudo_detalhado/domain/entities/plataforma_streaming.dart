import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/tipo_acesso.dart';

class PlataformaStreaming extends Equatable {
  final String codigo;
  final String nome;
  final String urlLogo;
  final String linkParaConteudo;
  final TipoAcesso tipoDeAcesso;

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
