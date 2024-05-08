import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';

final class SerieMapper implements Mapper<Serie> {
  @override
  Serie fromMap(Map<String, dynamic> map) => Serie(
        codigo: map['id'].toString(),
        titulo: map['name'],
        urlCapa: map['poster_path'],
        avaliacaoUsuario: map['vote_average'],
        favorito: false,
        assistirMaisTarde: false,
      );
}
