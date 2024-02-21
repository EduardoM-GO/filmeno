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
    required super.titulo,
    required super.urlCapa,
    required super.avaliacaoUsuario,
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
  ConteudoDetalhado copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
    String? faixaEtaria,
    DateTime? dataLancamento,
    Duration? duracao,
    List<String>? generos,
    String? sinopse,
    List<PlataformaStreaming>? plataformas,
    int? quantidadeDeTemporada,
  }) =>
      ConteudoDetalhado(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        urlCapa: urlCapa ?? this.urlCapa,
        avaliacaoUsuario: avaliacaoUsuario ?? this.avaliacaoUsuario,
        favorito: favorito ?? this.favorito,
        assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde,
        tipo: tipo,
        faixaEtaria: faixaEtaria ?? this.faixaEtaria,
        dataLancamento: dataLancamento ?? this.dataLancamento,
        duracao: duracao ?? this.duracao,
        generos: generos ?? this.generos,
        sinopse: sinopse ?? this.sinopse,
        plataformas: plataformas ?? this.plataformas,
        quantidadeDeTemporada:
            quantidadeDeTemporada ?? this.quantidadeDeTemporada,
      );

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
