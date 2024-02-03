import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';

class Conteudo extends Equatable {
  final String codigo;
  final String nome;
  final String urlCapa;
  final double avalicaoUsuario;
  final bool favorito;
  final bool assistirMaisTarde;
  final TipoConteudo tipo;

  const Conteudo({
    required this.codigo,
    required this.nome,
    required this.urlCapa,
    required this.avalicaoUsuario,
    required this.favorito,
    required this.assistirMaisTarde,
    required this.tipo,
  });

  @override
  List<Object?> get props => [
        codigo,
        nome,
        urlCapa,
        avalicaoUsuario,
        favorito,
        assistirMaisTarde,
        tipo
      ];
}
