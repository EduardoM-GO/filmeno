import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/conteudo_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';

final class SerieDetalhada extends ConteudoDetalhado {
  final int quantidadeDeEpisodios;
  final int quantidadeDeTemporada;

  const SerieDetalhada({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    required super.avaliacaoUsuario,
    super.favorito,
    super.assistirMaisTarde,
    required super.faixaEtaria,
    required super.dataLancamento,
    required this.quantidadeDeEpisodios,
    required this.quantidadeDeTemporada,
    required super.generos,
    required super.sinopse,
    required super.plataformas,
  }) : super(tipo: TipoConteudo.serie);

  @override
  SerieDetalhada copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
    String? faixaEtaria,
    DateTime? dataLancamento,
    int? quantidadeDeTemporada,
    int? quantidadeDeEpisodios,
    List<String>? generos,
    String? sinopse,
    List<PlataformaStreaming>? plataformas,
  }) =>
      SerieDetalhada(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        urlCapa: urlCapa ?? this.urlCapa,
        avaliacaoUsuario: avaliacaoUsuario ?? this.avaliacaoUsuario,
        favorito: favorito ?? this.favorito,
        assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde,
        faixaEtaria: faixaEtaria ?? this.faixaEtaria,
        dataLancamento: dataLancamento ?? this.dataLancamento,
        quantidadeDeEpisodios:
            quantidadeDeEpisodios ?? this.quantidadeDeEpisodios,
        quantidadeDeTemporada:
            quantidadeDeTemporada ?? this.quantidadeDeTemporada,
        generos: generos ?? this.generos,
        sinopse: sinopse ?? this.sinopse,
        plataformas: plataformas ?? this.plataformas,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        quantidadeDeEpisodios,
        quantidadeDeTemporada,
      ];
}
