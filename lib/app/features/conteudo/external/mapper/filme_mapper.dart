import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';

class FilmeMapper implements Mapper<Filme> {
  @override
  Filme fromMap(Map<String, dynamic> map) => Filme(
        codigo: map['id'].toString(),
        titulo: map['title'],
        urlCapa: map['poster_path'],
        avaliacaoUsuario: map['vote_average'],
        favorito: false,
        assistirMaisTarde: false,
      );
}
