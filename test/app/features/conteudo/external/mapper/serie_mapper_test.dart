import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/external/mapper/serie_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late SerieMapper mapper;

  setUp(() {
    mapper = SerieMapper();
  });

  test('serie mapper - fromMap', () {
    final result = mapper.fromMap({
      "adult": false,
      "backdrop_path": "/hib8MpBPU7GdluS38htXCF4uw0c.jpg",
      "genre_ids": [80, 18, 9648],
      "id": 2734,
      "origin_country": ["US"],
      "original_language": "en",
      "original_name": "Law & Order: Special Victims Unit",
      "overview":
          "Detetives que fazem parte da Unidade de Vítimas Especiais da polícia de Nova York investigam crimes de natureza sexual, como estupros, em que a vítima sobrevive, e auxilia as autoridades na investigação.",
      "popularity": 5919.758,
      "poster_path": "/gUMArcGnsNmsJgQky7vE0cdnf4Y.jpg",
      "first_air_date": "1999-09-20",
      "name": "Lei & Ordem: Unidade de Vítimas Especiais",
      "vote_average": 7.941,
      "vote_count": 3636
    });

    expect(result, isA<Serie>());
    expect(
      result,
      const Serie(
          codigo: '2734',
          titulo: 'Lei & Ordem: Unidade de Vítimas Especiais',
          urlCapa: '/gUMArcGnsNmsJgQky7vE0cdnf4Y.jpg',
          avaliacaoUsuario: 7.941,
          favorito: false,
          assistirMaisTarde: false),
    );
  });
}
