import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';

abstract base class ConteudoDetalhado extends Conteudo {
  final String faixaEtaria;
  final DateTime dataLancamento;
  final List<String> generos;
  final String sinopse;
  final List<PlataformaStreaming> plataformas;

  const ConteudoDetalhado({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    super.imagemCapa,
    required super.avaliacaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
    required super.tipo,
    required this.faixaEtaria,
    required this.dataLancamento,
    required this.generos,
    required this.sinopse,
    required this.plataformas,
  });

  @override
  ConteudoDetalhado copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
    String? faixaEtaria,
    DateTime? dataLancamento,
    List<String>? generos,
    String? sinopse,
    List<PlataformaStreaming>? plataformas,
  });

  @override
  List<Object?> get props => [
        ...super.props,
        faixaEtaria,
        dataLancamento,
        generos,
        sinopse,
        plataformas,
      ];
}
