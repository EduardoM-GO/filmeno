import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/serie_detalhada.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/tipo_acesso.dart';
import 'package:filmeno/app/features/conteudo_detalhado/external/mapper/serie_detalhado_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock/map/serie_detalhada_map.dart';

void main() {
  late SerieDetalhadoMapper mapper;

  setUp(() {
    mapper = SerieDetalhadoMapper();
  });

  test('serie detalhado mapper - fromMap', () {
    final result = mapper.fromMap(serieDetalhadaMap);

    expect(result, isA<SerieDetalhada>());
    expect(
      result,
      equals(
        SerieDetalhada(
            codigo: '76479',
            titulo: "The Boys",
            urlCapa: '/2zmTngn1tYC1AvfnrFLhxeD82hz.jpg',
            avaliacaoUsuario: 8.473,
            favorito: false,
            assistirMaisTarde: false,
            faixaEtaria: '18',
            dataLancamento: DateTime(2019, 07, 25),
            quantidadeDeEpisodios: 32,
            quantidadeDeTemporada: 5,
            generos: const ['Sci-Fi & Fantasy', 'Action & Adventure'],
            sinopse:
                "Na trama, conhecemos um mundo em que super-heróis são as maiores celebridades do planeta, e rotineiramente abusam dos seus poderes ao invés de os usarem para o bem.",
            plataformas: const [
              PlataformaStreaming(
                  codigo: '119',
                  nome: "Amazon Prime Video",
                  urlLogo: "/dQeAar5H991VYporEjUspolDarG.jpg",
                  linkParaConteudo:
                      "https://www.themoviedb.org/tv/76479-the-boys/watch?locale=BR",
                  tipoDeAcesso: TipoAcesso.assinatura)
            ]),
      ),
    );
  });

  group('serie detalhado mapper - getFaixaEtaria -', () {
    test('sem content_ratings', () {
      final result = mapper.getFaixaEtaria({});

      expect(result, equals(''));
    });

    test('sem results', () {
      final result = mapper.getFaixaEtaria({'content_ratings': {}});

      expect(result, equals(''));
    });

    test('sem iso_3166_1', () {
      final result = mapper.getFaixaEtaria({
        'content_ratings': {
          'results': [{}]
        }
      });

      expect(result, equals(''));
    });

    test('com iso_3166_1', () {
      final result = mapper.getFaixaEtaria({
        'content_ratings': {
          'results': [
            {'iso_3166_1': 'BR', 'rating': '18'}
          ]
        }
      });

      expect(result, equals('18'));
    });
  });
}
