import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';

class Filme extends Conteudo {
  const Filme({
    required super.codigo,
    required super.titulo,
    required super.urlCapa,
    required super.avalicaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
  }) : super(tipo: TipoConteudo.filme);

  @override
  Filme copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    double? avalicaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  }) =>
      Filme(
        codigo: codigo ?? this.codigo,
        titulo: titulo ?? this.titulo,
        urlCapa: urlCapa ?? this.urlCapa,
        avalicaoUsuario: avalicaoUsuario ?? this.avalicaoUsuario,
        favorito: favorito ?? this.favorito,
        assistirMaisTarde: assistirMaisTarde ?? this.assistirMaisTarde,
      );

  factory Filme.empty() => const Filme(
        codigo: '',
        titulo: '',
        urlCapa: '',
        avalicaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false,
      );
}
