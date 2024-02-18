import 'dart:convert';
import 'dart:typed_data';

import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/external/mapper/filme_mapper.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';
import 'package:filmeno/app/shared/external/mapper/metadados_http_mapper.dart';
import 'package:filmeno/app/shared/external/service/cliente_http_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../../mock/map/filme_map.dart';

class _MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late FilmeMapper mapper;
  late ClienteHttpServiceImpl serviceImpl;
  late String url;

  setUp(() {
    client = _MockClient();
    serviceImpl = ClienteHttpServiceImpl(client, MetadadosHttpMapper());
    mapper = FilmeMapper();
    url = 'https://api.themoviedb.org';
  });

  group('cliente http service impl - get -', () {
    late Uint8List jsonUtf8;

    setUp(() {
      jsonUtf8 = utf8.encode(jsonEncode({
        "adult": false,
        "backdrop_path": "/f1AQhx6ZfGhPZFTVKgxG91PhEYc.jpg",
        "genre_ids": [36, 10752, 28, 18],
        "id": 753342,
        "original_language": "en",
        "original_title": "Napoleon",
        "overview":
            "Um olhar pessoal sobre as origens do líder militar francês e sua rápida e implacável ascensão a imperador. A história é vista através do prisma do relacionamento dependente e volátil de Napoleão com sua esposa e amor verdadeiro, Josefina.",
        "popularity": 860.52,
        "poster_path": "/oaUS0YJN3cHpvin1BMNmmnv0gRX.jpg",
        "release_date": "2023-11-22",
        "title": "Napoleão",
        "video": false,
        "vote_average": 6.524,
        "vote_count": 1637
      }));
    });

    test('status == 200', () async {
      when(() => client.get(Uri.parse(url), headers: {'language': 'pt-BR'}))
          .thenAnswer((invocation) async => http.Response.bytes(jsonUtf8, 200));

      final result = await serviceImpl.get<Filme>(url: url, mapper: mapper);

      expect(result, isA<Filme>());

      expect(
          result,
          equals(const Filme(
              codigo: '753342',
              titulo: 'Napoleão',
              urlCapa: '/oaUS0YJN3cHpvin1BMNmmnv0gRX.jpg',
              avalicaoUsuario: 6.524,
              favorito: false,
              assistirMaisTarde: false)));
    });

    test('status != 200', () async {
      when(() => client.get(Uri.parse(url), headers: {'language': 'pt-BR'}))
          .thenAnswer((invocation) async => http.Response('', 201));

      expect(() async => serviceImpl.get<Filme>(url: url, mapper: mapper),
          throwsA(isA<http.Response>()));
    });
  });

  group('cliente http service impl - getList -', () {
    late Uint8List jsonUtf8;

    setUp(() {
      jsonUtf8 = utf8.encode(jsonEncode(filmeMap));
    });

    test('status == 200', () async {
      when(() => client
              .get(Uri.parse(url), headers: {'language': 'pt-BR', 'page': '1'}))
          .thenAnswer((invocation) async => http.Response.bytes(jsonUtf8, 200));

      final result = await serviceImpl.getList<Filme>(url: url, mapper: mapper);

      expect(result, isA<RespostaHttp<List<Filme>>>());
      expect(
          result.metadadosHttp,
          equals(const MetadadosHttp(
              paginaAtual: 2, quantidadePaginaTotal: 42438)));
      expect(result.resultado, isA<List<Filme>>());
      expect(result.resultado.length, equals(20));
    });

    test('status == 200 - sem dados', () async {
      final jsonUtf8Empty = utf8.encode(jsonEncode({
        "page": 2,
        "results": [],
        "total_pages": 42438,
        "total_results": 848741
      }));

      when(() => client
              .get(Uri.parse(url), headers: {'language': 'pt-BR', 'page': '1'}))
          .thenAnswer(
              (invocation) async => http.Response.bytes(jsonUtf8Empty, 200));

      final result = await serviceImpl.getList<Filme>(url: url, mapper: mapper);

      expect(result, isA<RespostaHttp<List<Filme>>>());
      expect(
          result,
          equals(const RespostaHttp<List<Filme>>(
              metadadosHttp:
                  MetadadosHttp(paginaAtual: 2, quantidadePaginaTotal: 42438),
              resultado: [])));
    });

    test('status != 200', () async {
      when(() => client
              .get(Uri.parse(url), headers: {'language': 'pt-BR', 'page': '1'}))
          .thenAnswer((invocation) async => http.Response('', 201));

      expect(() async => serviceImpl.getList<Filme>(url: url, mapper: mapper),
          throwsA(isA<http.Response>()));
    });
  });

  test('cliente http service impl - obterRespostaPorLista', () {
    final result =
        serviceImpl.obterRespostaPorLista<Filme>(map: filmeMap, mapper: mapper);

    expect(result, isA<RespostaHttp<List<Filme>>>());
    expect(result.metadadosHttp,
        const MetadadosHttp(paginaAtual: 2, quantidadePaginaTotal: 42438));
    expect(result.resultado, isA<List<Filme>>());
    expect(result.resultado.length, 20);
  });

  test('cliente http service impl - getImagem', () async {
    when(() => client.get(Uri.parse(url)))
        .thenAnswer((invocation) async => http.Response('', 200));

    final result = await serviceImpl.getImagem(url);

    expect(result, isA<Uint8List>());

    expect(result, Uint8List(0));
  });
}
