import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/external/datasources/filme_datasource_impl.dart';
import 'package:filmeno/app/shared/domain/entities/configuracao.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resposta_http.dart';
import 'package:filmeno/app/shared/external/mapper/mapper.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/cliente_http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockClienteHttpService extends Mock implements ClienteHttpService {}

class _MockMapper extends Mock implements Mapper<Filme> {}

void main() {
  late ClienteHttpService httpService;
  late Mapper<Filme> mapper;
  late FilmeDatasourceImpl datasourceImpl;
  late RespostaHttp<List<Filme>> respostaHttp;
  late List<Filme> resultado;

  setUp(() {
    httpService = _MockClienteHttpService();
    mapper = _MockMapper();
    datasourceImpl = FilmeDatasourceImpl(httpService, mapper);
    respostaHttp = const RespostaHttp(
        metadadosHttp: Metadados(paginaAtual: 1, quantidadePaginaTotal: 6),
        resultado: []);

    resultado = [];
  });

  group('filme datasource impl - buscarEmCartaz -', () {
    test('Ok', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/now_playing',
            headers: datasourceImpl.mapHeaders,
            mapper: mapper),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarEmCartaz();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/now_playing',
            mapper: mapper),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarEmCartaz();

      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('FilmeDatasourceImpl-buscarEmCartaz'));
    });
  });

  group('filme datasource impl - buscarMelhoresAvaliados -', () {
    test('Ok', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/top_rated',
            headers: datasourceImpl.mapHeaders,
            mapper: mapper),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarMelhoresAvaliados();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/top_rated',
            mapper: mapper),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarMelhoresAvaliados();

      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('FilmeDatasourceImpl-buscarMelhoresAvaliados'));
    });
  });

  group('filme datasource impl - buscarPopulares -', () {
    test('Ok', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/popular',
            headers: datasourceImpl.mapHeaders,
            mapper: mapper),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarPopulares();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/popular', mapper: mapper),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarPopulares();

      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('FilmeDatasourceImpl-buscarPopulares'));
    });
  });

  group('filme datasource impl - buscarProximasEstreias -', () {
    test('Ok', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/upcoming',
            headers: datasourceImpl.mapHeaders,
            mapper: mapper),
      ).thenAnswer((invocation) async => respostaHttp);

      final result = await datasourceImpl.buscarProximasEstreias();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => httpService.getList(
            url: '${Configuracao.I.apiUrlBase}/movie/upcoming', mapper: mapper),
      ).thenThrow(Exception());

      final result = await datasourceImpl.buscarProximasEstreias();

      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('FilmeDatasourceImpl-buscarProximasEstreias'));
    });
  });
}
