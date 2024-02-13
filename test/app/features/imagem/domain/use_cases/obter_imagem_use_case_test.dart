import 'dart:typed_data';

import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockImagemRepository extends Mock implements ImagemRepository {}

class _FakeImagem extends Fake implements Imagem {}

void main() {
  late ImagemRepository repository;
  late ObterImagemUseCaseImpl useCase;

  setUp(() {
    repository = _MockImagemRepository();
    useCase = ObterImagemUseCaseImpl(repository);
  });

  group('obter imagem use case - call -', () {
    late String url;
    late Imagem imagem;

    setUp(() {
      url = '';
      imagem =
          Imagem(dataCriacao: DateTime.now(), url: 'url', imagem: const []);
      registerFallbackValue(_FakeImagem());
    });

    test('Ok', () async {
      when(
        () => repository.obterImagem(url),
      ).thenAnswer((invocation) async => Success(Imagem.empty()));

      when(
        () => repository.buscarImagemApi(url),
      ).thenAnswer((invocation) async => Success(Uint8List(0)));

      when(
        () => repository.salvar(any()),
      ).thenAnswer((invocation) async => const Success(unit));

      final result = await useCase(url);

      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Imagem>());
      expect(result.getOrNull()?.imagem, equals(Uint8List(0)));
      expect(result.getOrNull()?.url, equals(url));
      expect(result.getOrNull()?.dataCriacao.isBefore(DateTime.now()),
          equals(true));
    });

    test('buscarImagemApi - erro', () async {
      when(
        () => repository.obterImagem(url),
      ).thenAnswer((invocation) async => Success(Imagem.empty()));

      when(
        () => repository.buscarImagemApi(url),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await useCase(url);

      expect(result.isError(), equals(true));
      expect(result.exceptionOrNull(), isA<Falha>());
    });

    test('isNotEmpty', () async {
      when(
        () => repository.obterImagem(url),
      ).thenAnswer((invocation) async => Success(imagem));

      final result = await useCase(url);

      expect(result.isSuccess(), equals(true));
      expect(result.getOrNull(), isA<Imagem>());
      expect(result.getOrNull(), equals(imagem));
    });

    test('obterImagem - erro', () async {
      when(
        () => repository.obterImagem(url),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await useCase(url);

      expect(result.isError(), equals(true));
      expect(result.exceptionOrNull(), isA<Falha>());
    });
  });

  group('obter imagem use case - salvarEmCache', () {
    late Imagem imagem;

    setUp(() {
      imagem =
          Imagem(dataCriacao: DateTime.now(), url: 'url', imagem: const []);
    });

    test('Ok', () async {
      when(
        () => repository.salvar(imagem),
      ).thenAnswer((invocation) async => const Success(unit));

      final result = await useCase.salvarEmCache(imagem);

      expect(result, equals(imagem));
    });

    test('Erro', () async {
      when(
        () => repository.salvar(imagem),
      ).thenAnswer((invocation) async => Failure(avisoMock));

      final result = await useCase.salvarEmCache(imagem);

      expect(result, equals(imagem));
    });
  });
}
