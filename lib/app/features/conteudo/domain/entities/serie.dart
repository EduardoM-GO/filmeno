import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';

final class Serie extends Conteudo {
  const Serie({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    super.imagemCapa,
    required super.avaliacaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
  }) : super(tipo: TipoConteudo.serie);

  @override
  Conteudo copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  }) =>
      Serie(
          codigo: codigo ?? this.codigo,
          titulo: titulo ?? this.titulo,
          urlCapa: urlCapa ?? this.urlCapa,
          imagemCapa: imagemCapa ?? this.imagemCapa,
          avaliacaoUsuario: avaliacaoUsuario ?? this.avaliacaoUsuario,
          favorito: favorito ?? this.favorito,
          assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde);
}
