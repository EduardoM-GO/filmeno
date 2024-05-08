import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';

final class Filme extends Conteudo {
  const Filme({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    super.imagemCapa,
    required super.avaliacaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
  }) : super(tipo: TipoConteudo.filme);

  @override
  Filme copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  }) =>
      Filme(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        urlCapa: urlCapa ?? this.urlCapa,
        imagemCapa: imagemCapa ?? this.imagemCapa,
        avaliacaoUsuario: avaliacaoUsuario ?? this.avaliacaoUsuario,
        favorito: favorito ?? this.favorito,
        assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde,
      );

  factory Filme.empty() => const Filme(
        codigo: '',
        titulo: '',
        urlCapa: '',
        avaliacaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
      );
}
