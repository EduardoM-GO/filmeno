import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/plataforma_streaming.dart';
import 'package:filmeno/app/features/conteudo_detalhado/domain/entities/tipo_acesso.dart';
import 'package:filmeno/app/shared/external/mapper/plataformas_mapper_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mock/map/plataformas_map.dart';

class _PlataformasMapperMixinTest with PlataformasMapperMixin {}

void main() {
  late PlataformasMapperMixin mixin;

  setUp(() {
    mixin = _PlataformasMapperMixinTest();
  });

  group('plataformas mapper mixin - getPlataformas -', () {
    test('Com dados', () {
      const String link =
          'https://www.themoviedb.org/movie/719221-tarot/watch?locale=BR';
      final result = mixin.getPlataformas(plataformasMap);

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, hasLength(10));
      expect(
        result,
        equals([
          const PlataformaStreaming(
            codigo: '3',
            nome: 'Google Play Movies',
            urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.assinatura,
          ),
          const PlataformaStreaming(
            codigo: '167',
            nome: 'Claro video',
            urlLogo: '/21M5CpiOYGOhHj2sVPXqwt6yeTO.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.alugar,
          ),
          const PlataformaStreaming(
            codigo: '2',
            nome: 'Apple TV',
            urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.alugar,
          ),
          const PlataformaStreaming(
            codigo: '10',
            nome: 'Amazon Video',
            urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.alugar,
          ),
          const PlataformaStreaming(
            codigo: '3',
            nome: 'Google Play Movies',
            urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.alugar,
          ),
          const PlataformaStreaming(
            codigo: '68',
            nome: 'Microsoft Store',
            urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.alugar,
          ),
          const PlataformaStreaming(
            codigo: '2',
            nome: 'Apple TV',
            urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.comprar,
          ),
          const PlataformaStreaming(
            codigo: '10',
            nome: 'Amazon Video',
            urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.comprar,
          ),
          const PlataformaStreaming(
            codigo: '3',
            nome: 'Google Play Movies',
            urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.comprar,
          ),
          const PlataformaStreaming(
            codigo: '68',
            nome: 'Microsoft Store',
            urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
            linkParaConteudo: link,
            tipoDeAcesso: TipoAcesso.comprar,
          ),
        ]),
      );
    });

    test('Sem watch/providers', () {
      final result = mixin.getPlataformas({});

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
    test('Sem results', () {
      final result = mixin.getPlataformas({"watch/providers": {}});

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
    test('Sem streaming', () {
      final result = mixin.getPlataformas({
        "watch/providers": {"results": {}}
      });

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
  });

  group('plataformas mapper mixin - getPlataformasDeAssinatura -', () {
    late Map<String, dynamic> map;

    setUp(() {
      map = plataformasMap['watch/providers']['results']['BR'];
    });

    test('Lista com dados', () {
      final result = mixin.getPlataformasDeAssinatura(map: map, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, hasLength(1));
      expect(
          result,
          equals([
            const PlataformaStreaming(
              codigo: '3',
              nome: 'Google Play Movies',
              urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.assinatura,
            ),
          ]));
    });

    test('Deve retornar uma lista vazia', () {
      final result = mixin.getPlataformasDeAssinatura(map: {}, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
  });

  group('plataformas mapper mixin - getPlataformasDeAlugar -', () {
    late Map<String, dynamic> map;

    setUp(() {
      map = plataformasMap['watch/providers']['results']['BR'];
    });

    test('Lista com dados', () {
      final result = mixin.getPlataformasDeAlugar(map: map, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, hasLength(5));
      expect(
          result,
          equals([
            const PlataformaStreaming(
              codigo: '167',
              nome: 'Claro video',
              urlLogo: '/21M5CpiOYGOhHj2sVPXqwt6yeTO.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.alugar,
            ),
            const PlataformaStreaming(
              codigo: '2',
              nome: 'Apple TV',
              urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.alugar,
            ),
            const PlataformaStreaming(
              codigo: '10',
              nome: 'Amazon Video',
              urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.alugar,
            ),
            const PlataformaStreaming(
              codigo: '3',
              nome: 'Google Play Movies',
              urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.alugar,
            ),
            const PlataformaStreaming(
              codigo: '68',
              nome: 'Microsoft Store',
              urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.alugar,
            ),
          ]));
    });

    test('Deve retornar uma lista vazia', () {
      final result = mixin.getPlataformasDeAlugar(map: {}, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
  });

  group('plataformas mapper mixin - getPlataformasDeComprar -', () {
    late Map<String, dynamic> map;

    setUp(() {
      map = plataformasMap['watch/providers']['results']['BR'];
    });

    test('Lista com dados', () {
      final result = mixin.getPlataformasDeComprar(map: map, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, hasLength(4));
      expect(
          result,
          equals([
            const PlataformaStreaming(
              codigo: '2',
              nome: 'Apple TV',
              urlLogo: '/9ghgSC0MA082EL6HLCW3GalykFD.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.comprar,
            ),
            const PlataformaStreaming(
              codigo: '10',
              nome: 'Amazon Video',
              urlLogo: '/seGSXajazLMCKGB5hnRCidtjay1.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.comprar,
            ),
            const PlataformaStreaming(
              codigo: '3',
              nome: 'Google Play Movies',
              urlLogo: '/8z7rC8uIDaTM91X0ZfkRf04ydj2.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.comprar,
            ),
            const PlataformaStreaming(
              codigo: '68',
              nome: 'Microsoft Store',
              urlLogo: '/5vfrJQgNe9UnHVgVNAwZTy0Jo9o.jpg',
              linkParaConteudo: 'link',
              tipoDeAcesso: TipoAcesso.comprar,
            ),
          ]));
    });

    test('Deve retornar uma lista vazia', () {
      final result = mixin.getPlataformasDeComprar(map: {}, link: 'link');

      expect(result, isA<List<PlataformaStreaming>>());
      expect(result, isEmpty);
    });
  });
}
