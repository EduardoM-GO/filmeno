import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';

abstract class Conteudo extends Equatable {
  final String codigo;
  final String titulo;
  final String urlCapa;
  final double avalicaoUsuario;
  final bool favorito;
  final bool assistirMaisTarde;
  final TipoConteudo tipo;

  const Conteudo({
    required this.codigo,
    required this.titulo,
    required this.urlCapa,
    required this.avalicaoUsuario,
    required this.favorito,
    required this.assistirMaisTarde,
    required this.tipo,
  });

  Conteudo copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    double? avalicaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  });

  @override
  List<Object?> get props => [
        codigo,
        titulo,
        urlCapa,
        avalicaoUsuario,
        favorito,
        assistirMaisTarde,
        tipo
      ];
}
