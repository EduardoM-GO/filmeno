import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/infra/cache/imagem_cache.dart';
import 'package:filmeno/app/features/imagem/infra/repositories/imagem_repository_impl.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockImagemCache extends Mock implements ImagemCache {}

void main() {
  late ImagemCache cache;
  late ImagemRepositoryImpl repository;

  setUp(() {
    cache = _MockImagemCache();
    repository = ImagemRepositoryImpl(cache);
  });

  group('imagem repository impl - excluirCacheAntigos -', () {
    test('Ok', () async {
      when(
        () => cache.excluirCacheAntigos(),
      ).thenAnswer((invocation) async => const Success(unit));

      final result = await repository.excluirCacheAntigos();

      expect(result.isSuccess(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Unit>());
    });

    test('Erro', () async {
      when(
        () => cache.excluirCacheAntigos(),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await repository.excluirCacheAntigos();

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('imagem repository impl - obterImagem -', () {
    late String url;

    setUp(() => url = 'url');
    test('Ok', () async {
      when(
        () => cache.obterImagem(url),
      ).thenAnswer((invocation) async => Success(Imagem.empty()));

      final result = await repository.obterImagem(url);

      expect(result.isSuccess(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Imagem>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(Imagem.empty()));
    });

    test('Erro', () async {
      when(
        () => cache.obterImagem(url),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await repository.obterImagem(url);

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });

  group('imagem repository impl - salvar -', () {
    late Imagem imagem;

    setUp(() => imagem = Imagem.empty());
    test('Ok', () async {
      when(
        () => cache.salvar(imagem),
      ).thenAnswer((invocation) async => const Success(unit));

      final result = await repository.salvar(imagem);

      expect(result.isSuccess(), equals(true));
      expect(
          result.fold((success) => success, (failure) => failure), isA<Unit>());
    });

    test('Erro', () async {
      when(
        () => cache.salvar(imagem),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await repository.salvar(imagem);

      expect(result.isError(), equals(true));
      expect(result.fold((success) => success, (failure) => failure),
          isA<Falha>());
      expect(result.fold((success) => success, (failure) => failure),
          equals(avisoMock));
    });
  });
}
