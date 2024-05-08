import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/external/datasources/serie_datasource_impl.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClienteHttpService extends Mock implements ClienteHttpService {}

class _MockMapper extends Mock implements Mapper<Serie> {}

void main() {
  late ClienteHttpService httpService;
  late Mapper<Serie> mapper;
  late SerieDatasourceImpl datasourceImpl;
  late RespostaHttp<List<Serie>> respostaHttp;
  late List<Serie> resultado;

  setUp(() {
    httpService = _MockClienteHttpService();
    mapper = _MockMapper();
    datasourceImpl = SerieDatasourceImpl(httpService, mapper);
    respostaHttp = const RespostaHttp(
      metadadosHttp: Metadados(paginaAtual: 1, quantidadePaginaTotal: 6),
      resultado: [],
    );

    resultado = [];
  });

  group('serie datasource impl - buscarMelhoresAvaliados -', () {
    test('Ok', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/top_rated',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarMelhoresAvaliados();

      expect(result.isSuccess(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<List<Serie>>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure),
        equals(resultado),
      );
    });

    test('Erro', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/top_rated',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarMelhoresAvaliados();

      expect(result.isError(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<Erro>(),
      );
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('SerieDatasourceImpl-buscarMelhoresAvaliados'));
    });
  });

  group('serie datasource impl - buscarPopular -', () {
    test('Ok', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/popular',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarPopular();

      expect(result.isSuccess(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<List<Serie>>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure),
        equals(resultado),
      );
    });

    test('Erro', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/popular',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarPopular();

      expect(result.isError(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<Erro>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure.tagMetodo),
        equals('SerieDatasourceImpl-buscarPopular'),
      );
    });
  });

  group('serie datasource impl - buscarVaiSerExibidoHoje -', () {
    test('Ok', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/airing_today',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarVaiSerExibidoHoje();

      expect(result.isSuccess(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<List<Serie>>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure),
        equals(resultado),
      );
    });

    test('Erro', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/airing_today',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarVaiSerExibidoHoje();

      expect(result.isError(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<Erro>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure.tagMetodo),
        equals('SerieDatasourceImpl-buscarVaiSerExibidoHoje'),
      );
    });
  });

  group('serie datasource impl - buscarVaiSerExibidoNaSemana -', () {
    test('Ok', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/on_the_air',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarVaiSerExibidoNaSemana();

      expect(result.isSuccess(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<List<Serie>>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure),
        equals(resultado),
      );
    });

    test('Erro', () async {
      when(
        () => httpService.getList<Serie>(
          url: '${Configuracao.instance.apiUrlBase}/tv/on_the_air',
          headers: datasourceImpl.mapHeaders,
          mapper: mapper,
        ),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarVaiSerExibidoNaSemana();

      expect(result.isError(), equals(true));
      expect(
        result.fold((success) => success, (failure) => failure),
        isA<Erro>(),
      );
      expect(
        result.fold((success) => success, (failure) => failure.tagMetodo),
        equals('SerieDatasourceImpl-buscarVaiSerExibidoNaSemana'),
      );
    });
  });
}
