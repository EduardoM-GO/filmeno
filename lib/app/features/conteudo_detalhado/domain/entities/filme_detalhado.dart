import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/conteudo_detalhado.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';

final class FilmeDetalhado extends ConteudoDetalhado {
  final Duration duracao;

  const FilmeDetalhado({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    required super.avaliacaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
    required super.faixaEtaria,
    required super.dataLancamento,
    required this.duracao,
    required super.generos,
    required super.sinopse,
    required super.plataformas,
  }) : super(tipo: TipoConteudo.filme);

  @override
  FilmeDetalhado copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
    String? faixaEtaria,
    DateTime? dataLancamento,
    Duration? duracao,
    List<String>? generos,
    String? sinopse,
    List<PlataformaStreaming>? plataformas,
  }) =>
      FilmeDetalhado(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        urlCapa: urlCapa ?? this.urlCapa,
        avaliacaoUsuario: avaliacaoUsuario ?? this.avaliacaoUsuario,
        favorito: favorito ?? this.favorito,
        assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde,
        faixaEtaria: faixaEtaria ?? this.faixaEtaria,
        dataLancamento: dataLancamento ?? this.dataLancamento,
        duracao: duracao ?? this.duracao,
        generos: generos ?? this.generos,
        sinopse: sinopse ?? this.sinopse,
        plataformas: plataformas ?? this.plataformas,
      );

  @override
  List<Object?> get props => [
        ...super.props,
        duracao,
      ];
}
