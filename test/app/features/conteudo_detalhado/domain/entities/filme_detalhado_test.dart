import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/filme_detalhado.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('filme detalhado - copyWith -', () {
    late FilmeDetalhado filmeDetalhado;

    setUp(() {
      filmeDetalhado = FilmeDetalhado(
        codigo: '1',
        titulo: 'Filme 1',
        urlCapa: '/url',
        avaliacaoUsuario: 8.0,
        favorito: false,
        assistirMaisTarde: false,
        faixaEtaria: '16',
        dataLancamento: DateTime.now(),
        duracao: const Duration(minutes: 120),
        generos: const ['Ação'],
        sinopse: 'Sinopse',
        plataformas: const [],
      );
    });

    test('Com alteracão', () {
      final result = filmeDetalhado.copyWith(
        codigo: '2',
        titulo: 'Filme 2',
        urlCapa: '/url2',
        avaliacaoUsuario: 9.0,
        favorito: true,
        assistirMaisTarde: true,
        faixaEtaria: '18',
        dataLancamento: DateTime.now().add(const Duration(days: 1)),
        duracao: const Duration(minutes: 130),
        generos: const ['Ação', 'Comédia'],
        sinopse: 'Sinopse 2',
        plataformas: const [],
      );

      expect(result.codigo, equals('2'));
      expect(result.titulo, equals('Filme 2'));
      expect(result.urlCapa, equals('/url2'));
      expect(result.avaliacaoUsuario, equals(9.0));
      expect(result.favorito, isTrue);
      expect(result.assistirMaisTarde, isTrue);
      expect(result.faixaEtaria, equals('18'));
      expect(result.dataLancamento, isNot(equals(DateTime.now())));
      expect(result.duracao, equals(const Duration(minutes: 130)));
      expect(result.generos, equals(const ['Ação', 'Comédia']));
      expect(result.sinopse, equals('Sinopse 2'));
      expect(result.plataformas, equals(const []));
    });

    test('Sem alteracão', () {
      final result = filmeDetalhado.copyWith();

      expect(result, equals(filmeDetalhado));
    });
  });
}
