import 'package:equatable/equatable.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/tipo_conteudo.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:intl/intl.dart';

abstract base class Conteudo extends Equatable {
  final String codigo;
  final String titulo;
  final String urlCapa;
  final Imagem? imagemCapa;
  final double avaliacaoUsuario;
  final bool favorito;
  final bool assistirMaisTarde;
  final TipoConteudo tipo;

  const Conteudo({
    required this.codigo,
    required this.titulo,
    required this.urlCapa,
    this.imagemCapa,
    required this.avaliacaoUsuario,
    required this.favorito,
    required this.assistirMaisTarde,
    required this.tipo,
  });

  Conteudo copyWith({
    String? codigo,
    String? titulo,
    String? urlCapa,
    Imagem? imagemCapa,
    double? avaliacaoUsuario,
    bool? favorito,
    bool? assistirMaisTarde,
  });

  String get avaliacaoUsuarioFormatada => NumberFormat.decimalPercentPattern(
        locale: 'pt_BR',
        decimalDigits: 0,
      ).format(avaliacaoUsuario / 10);

  @override
  List<Object?> get props => [
        codigo,
        titulo,
        urlCapa,
        imagemCapa,
        avaliacaoUsuario,
        favorito,
        assistirMaisTarde,
        tipo
      ];
}
