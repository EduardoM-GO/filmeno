import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';

class Filme extends Conteudo {
  const Filme({
    required super.codigo,
    required super.nome,
    required super.urlCapa,
    required super.avalicaoUsuario,
    required super.favorito,
    required super.assistirMaisTarde,
  }) : super(tipo: TipoConteudo.filme);
}
