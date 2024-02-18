import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/features/conteudo/infra/repositories/filme_repository_impl.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeDatasource extends Mock implements FilmeDatasource {}

void main() {
  late FilmeDatasource datasource;
  late FilmeRepositoryImpl repository;
  late ResultadoComMetadados<List<Filme>> resultado;

  setUp(() {
    datasource = _MockFilmeDatasource();
    repository = FilmeRepositoryImpl(datasource);
    resultado = const ResultadoComMetadados(
        resultado: [],
        metadados: MetadadosHttp(paginaAtual: 0, quantidadePaginaTotal: 0));
  });

  group('filme repository impl - buscarEmCartaz -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarEmCartaz(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarEmCartaz();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<ResultadoComMetadados<List<Filme>>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarEmCartaz(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarEmCartaz();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('filme repository impl - buscarMelhoresAvalidados -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarMelhoresAvalidados(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarMelhoresAvalidados();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<ResultadoComMetadados<List<Filme>>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarMelhoresAvalidados(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarMelhoresAvalidados();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('filme repository impl - buscarPopulares -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarPopulares(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarPopulares();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<ResultadoComMetadados<List<Filme>>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarPopulares(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarPopulares();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('filme repository impl - buscarProximasEstreias -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarProximasEstreias(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarProximasEstreias();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<ResultadoComMetadados<List<Filme>>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarProximasEstreias(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarProximasEstreias();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });
}
