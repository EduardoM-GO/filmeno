import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/infra/datasources/serie_datasource.dart';
import 'package:filmeno/app/features/conteudo/infra/repositories/serie_repository_impl.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockSerieDatasource extends Mock implements SerieDatasource {}

void main() {
  late SerieDatasource datasource;
  late SerieRepositoryImpl repository;
  late List<Serie> resultado;

  setUp(() {
    datasource = _MockSerieDatasource();
    repository = SerieRepositoryImpl(datasource);
    resultado = [];
  });

  group('serie repository impl - buscarMelhoresAvaliados -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarMelhoresAvaliados(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarMelhoresAvaliados();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Serie>>());
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

  group('serie repository impl - buscarPopular -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarPopular(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarPopular();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Serie>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarPopular(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarPopular();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('serie repository impl - buscarVaiSerExibidoHoje -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarVaiSerExibidoHoje(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarVaiSerExibidoHoje();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Serie>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarVaiSerExibidoHoje(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarVaiSerExibidoHoje();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('serie repository impl - buscarVaiSerExibidoNaSemana -', () {
    test('Ok', () async {
      when(
        () => datasource.buscarVaiSerExibidoNaSemana(),
      ).thenAnswer((invocation) async => Success(resultado));
      final result = await repository.buscarVaiSerExibidoNaSemana();

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<List<Serie>>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(resultado));
    });

    test('Erro', () async {
      when(
        () => datasource.buscarVaiSerExibidoNaSemana(),
      ).thenAnswer((invocation) async => Failure(avisoMock));
      final result = await repository.buscarVaiSerExibidoNaSemana();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });
}
