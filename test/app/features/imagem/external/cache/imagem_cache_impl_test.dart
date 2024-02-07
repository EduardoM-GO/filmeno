import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/external/cache/imagem_cache_impl.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:filmeno/app/shared/infra/service/db_helper_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

class _MockDbHelperService extends Mock implements DbHelperService {}

class _MockIsarCollection<Imagem> extends Mock
    implements IsarCollection<Imagem> {}

class _MockIsar extends Mock implements Isar {
  @override
  Future<T> writeTxn<T>(Future<T> Function() callback, {bool silent = false}) =>
      callback();
}

class _MockQueryBuilderInternal extends Mock
    implements QueryBuilderInternal<Imagem> {}

class _FakeFilterCondition extends Fake implements FilterCondition {}

class MockQuery extends Mock implements Query<Imagem> {}

void main() {
  late DbHelperService service;
  late Isar isar;
  late IsarCollection<Imagem> collection;
  late ImagemCacheImpl cacheImpl;

  setUpAll(() async {
    await Isar.initializeIsarCore(download: true);
  });

  setUp(() {
    service = _MockDbHelperService();
    isar = _MockIsar();
    cacheImpl = ImagemCacheImpl(service);
    when(
      () => service.getInstancia(),
    ).thenAnswer((invocation) async => isar);
    collection = _MockIsarCollection();
    when(
      () => isar.imagems,
    ).thenReturn(collection);
  });

  tearDownAll(() async {
    await Isar.getInstance()?.close(deleteFromDisk: true);
  });

  group('imagem cache impl - obterImagem -', () {
    test('Imagem localizada', () async {
      final Imagem imagem =
          Imagem(dataCriacao: DateTime.now(), url: 'url', imagem: Uint8List(0));

      when(
        () => collection.getByUrl('url'),
      ).thenAnswer((invocation) async => imagem);
      final result = await cacheImpl.obterImagem('url');
      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Imagem>());
      expect(result.getOrNull(), equals(imagem));
    });

    test('Imagem Não localizada', () async {
      when(
        () => collection.getByUrl('url'),
      ).thenAnswer((invocation) async => null);
      final result = await cacheImpl.obterImagem('url');
      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Imagem>());
      expect(result.getOrNull(), equals(Imagem.empty()));
    });

    test('Erro', () async {
      when(
        () => collection.getByUrl('url'),
      ).thenThrow(Exception());
      final result = await cacheImpl.obterImagem('url');
      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('ImagemCacheImpl-obterImagem'));
    });
  });

  group('imagem cache impl - salvar -', () {
    late Imagem imagem;
    setUp(() {
      imagem =
          Imagem(dataCriacao: DateTime.now(), url: 'url', imagem: Uint8List(0));
    });

    test('ok', () async {
      when(
        () => collection.put(imagem),
      ).thenAnswer((invocation) async => 0);

      final result = await cacheImpl.salvar(imagem);
      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Unit>());
    });

    test('Erro', () async {
      when(
        () => collection.put(imagem),
      ).thenThrow(Exception());

      final result = await cacheImpl.salvar(imagem);
      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('ImagemCacheImpl-salvar'));
    });
  });

  group('imagem cache impl - excluirCacheAntigos -', () {
    late QueryBuilderInternal<Imagem> queryBuilderInternal;
    late QueryBuilder<Imagem, Imagem, QAfterFilterCondition> queryBuilder;
    late Query<Imagem> query;
    setUp(() {
      queryBuilderInternal = _MockQueryBuilderInternal();
      queryBuilder = QueryBuilder(queryBuilderInternal);
      query = MockQuery();
      registerFallbackValue(_FakeFilterCondition());
    });

    test('ok', () async {
      when(
        () => collection.filter(),
      ).thenReturn(queryBuilder);
      when(
        () => queryBuilder.dataCriacaoLessThan(cacheImpl.dataLimiteCacheAntigo),
      ).thenAnswer((invocation) => queryBuilder);

      when(
        () => queryBuilderInternal.addFilterCondition(any<FilterCondition>()),
      ).thenReturn(queryBuilderInternal);

      when(
        () => queryBuilder.build(),
      ).thenReturn(query);

      when(
        () => query.deleteAll(),
      ).thenAnswer((invocation) async => 0);

      final result = await cacheImpl.excluirCacheAntigos();
      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Unit>());
    });

    test('Erro', () async {
      when(
        () => collection.filter(),
      ).thenThrow(Exception());

      final result = await cacheImpl.excluirCacheAntigos();
      expect(result.isError(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Erro>());
      expect(result.fold((success) => success, (failure) => failure.tagMetodo),
          equals('ImagemCacheImpl-excluirCacheAntigos'));
    });
  });
}
