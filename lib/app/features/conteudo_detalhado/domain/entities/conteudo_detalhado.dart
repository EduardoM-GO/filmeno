import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';

class ConteudoDetalhado extends Conteudo {
  final String faixaEtaria;
  final DateTime dataLancamento;
  final Duration duracao;
  final List<String> generos;
  final String sinopse;
  final List<PlataformaStreaming> plataformas;
  final int? quantidadeDeTemporada;

  const ConteudoDetalhado({
    required super.codigo,
    required super.nome,
    required super.urlCapa,
    required super.avalicaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
    required super.tipo,
    required this.faixaEtaria,
    required this.dataLancamento,
    required this.duracao,
    required this.generos,
    required this.sinopse,
    required this.plataformas,
    required this.quantidadeDeTemporada,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        faixaEtaria,
        dataLancamento,
        duracao,
        generos,
        sinopse,
        plataformas,
        quantidadeDeTemporada
      ];
}
