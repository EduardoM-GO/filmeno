import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('serie detalhada - copyWith -', () {
    late SerieDetalhada serieDetalhada;

    setUp(() {
      serieDetalhada = SerieDetalhada(
        codigo: '1',
        titulo: 'titulo',
        urlCapa: 'urlCapa',
        avaliacaoUsuario: 1.0,
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: 'L',
        dataLancamento: DateTime.now(),
        quantidadeDeEpisodios: 1,
        quantidadeDeTemporada: 1,
        generos: const ['genero'],
        sinopse: 'sinopse',
        plataformas: const [],
      );
    });

    test('Com alteração', () {
      final result = serieDetalhada.copyWith(
        codigo: '2',
        titulo: 'titulo2',
        urlCapa: 'urlCapa2',
        avaliacaoUsuario: 2.0,
        favorito: true,
        assistirMaisTarde: true,
        faixaEtaria: 'L2',
        dataLancamento: DateTime.now().add(const Duration(days: 1)),
        quantidadeDeEpisodios: 2,
        quantidadeDeTemporada: 2,
        generos: const ['genero2'],
        sinopse: 'sinopse2',
        plataformas: const [],
      );

      expect(result.codigo, equals('2'));
      expect(result.titulo, equals('titulo2'));
      expect(result.urlCapa, equals('urlCapa2'));
      expect(result.avaliacaoUsuario, equals(2.0));
      expect(result.favorito, isTrue);
      expect(result.assistirMaisTarde, isTrue);
      expect(result.faixaEtaria, equals('L2'));
      expect(result.dataLancamento, isNot(equals(DateTime.now())));
      expect(result.quantidadeDeEpisodios, equals(2));
      expect(result.quantidadeDeTemporada, equals(2));
      expect(result.generos, equals(const ['genero2']));
      expect(result.sinopse, equals('sinopse2'));
      expect(result.plataformas, equals(const []));
    });

    test('Sem alteração', () {
      final result = serieDetalhada.copyWith();

      expect(result, equals(serieDetalhada));
    });
  });
}
