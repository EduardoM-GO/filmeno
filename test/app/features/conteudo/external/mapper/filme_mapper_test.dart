import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/external/mapper/filme_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late FilmeMapper mapper;

  setUp(() {
    mapper = FilmeMapper();
  });

  test('filme mapper - fromMap', () {
    final result = mapper.fromMap({
      "adult": false,
      "backdrop_path": "/pWsD91G2R1Da3AKM3ymr3UoIfRb.jpg",
      "genre_ids": [878, 28, 18],
      "id": 933131,
      "original_language": "ko",
      "original_title": "황야",
      "overview":
          "Após um terremoto transformar Seul em uma terra sem lei, um caçador decide resgatar uma adolescente sequestrada por um médico insano.",
      "popularity": 3228.455,
      "poster_path": "/vT3xahepzP796ei0NiZIZ6t8vsl.jpg",
      "release_date": "2024-01-26",
      "title": "Em Ruínas",
      "video": false,
      "vote_average": 6.925,
      "vote_count": 288
    });

    expect(result, isA<Filme>());
    expect(
      result,
      const Filme(
          codigo: '933131',
          titulo: 'Em Ruínas',
          urlCapa: '/vT3xahepzP796ei0NiZIZ6t8vsl.jpg',
          avaliacaoUsuario: 6.925,
          favorito: false,
          assistirMaisTarde: false),
    );
  });
}
