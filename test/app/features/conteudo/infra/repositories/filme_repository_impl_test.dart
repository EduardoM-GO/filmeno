import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/filme_datasource.dart';
import 'package:filmeno/app/features/conteudo/infra/repositories/filme_repository_impl.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeDatasource extends Mock implements FilmeDatasource {}

void main() {
  late FilmeDatasource datasource;
  late FilmeRepositoryImpl repository;
  late List<Filme> resultado;

  setUp(() {
    datasource = _MockFilmeDatasource();
    repository = FilmeRepositoryImpl(datasource);
    resultado = [];
  });

  group('filme repository impl - buscarEmCartaz -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarEmCartaz(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarEmCartaz();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
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

  group('filme repository impl - buscarMelhoresAvaliados -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarMelhoresAvaliados(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarMelhoresAvaliados();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Filme>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarMelhoresAvaliados(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarMelhoresAvaliados();

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
          isA<List<Filme>>());
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
          isA<List<Filme>>());
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
