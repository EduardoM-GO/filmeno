import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('serie - copyWith -', () {
    late Serie serie;

    setUp(() {
      serie = const Serie(
        codigo: '1',
        titulo: 'titulo',
        urlCapa: 'urlCapa',
        avaliacaoUsuario: 5.0,
        favorito: true,
        assistirMaisTarde: false,
      );
    });

    test('Com mudança', () {
      final serieCopy = serie.copyWith(
        codigo: '2',
        titulo: 'titulo2',
        urlCapa: 'urlCapa2',
        avaliacaoUsuario: 4.0,
        favorito: false,
        assistirMaisTarde: true,
      );

      expect(
          serieCopy,
          equals(
            const Serie(
              codigo: '2',
              titulo: 'titulo2',
              urlCapa: 'urlCapa2',
              avaliacaoUsuario: 4.0,
              favorito: false,
              assistirMaisTarde: true,
            ),
          ));
    });

    test('Sem mudança', () {
      final serieCopy = serie.copyWith();

      expect(
          serieCopy,
          equals(
            const Serie(
              codigo: '1',
              titulo: 'titulo',
              urlCapa: 'urlCapa',
              avaliacaoUsuario: 5.0,
              favorito: true,
              assistirMaisTarde: false,
            ),
          ));
    });
  });
}
