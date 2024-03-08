import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';

abstract class Conteudo extends Equatable {
  final String codigo;
  final String titulo;
  final String urlCapa;
  final double _avaliacaoUsuario;
  final bool favorito;
  final bool assistirMaisTarde;
  final TipoConteudo tipo;

  const Conteudo({
    required this.codigo,
    required this.titulo,
    required this.urlCapa,
    required double avaliacaoUsuario,
    required this.favorito,
    required this.assistirMaisTarde,
    required this.tipo,
  }) : _avaliacaoUsuario = avaliacaoUsuario;

  Conteudo copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  });

  double get avaliacaoUsuario => _avaliacaoUsuario / 10;

  @override
  List<Object?> get props => [
        codigo,
        titulo,
        urlCapa,
        _avaliacaoUsuario,
        favorito,
        assistirMaisTarde,
        tipo
      ];
}
