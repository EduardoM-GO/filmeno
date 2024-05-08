import 'package:filmeno/app/features/conteudo/domain/entities/serie.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/serie_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_series_populares_use_case.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockSerieRepository extends Mock implements SerieRepository {}

class _MockImagemRepository extends Mock implements ImagemRepository {}

void main() {
  late SerieRepository repository;
  late BuscarSeriesPopularesUseCaseImpl useCase;

  setUp(() {
    repository = _MockSerieRepository();
    useCase = BuscarSeriesPopularesUseCaseImpl(
      repository,
      _MockImagemRepository(),
    );
  });

  test('buscar series populares use case - Ok', () async {
    final List<Serie> series = [];

    when(() => repository.buscarPopular())
        .thenAnswer((_) async => Success(series));

    final result = await useCase.call();

    expect(result.isSuccess(), equals(true));
    expect(result.getOrThrow(), isA<List<Serie>>());
    expect(result.getOrThrow(), equals(series));
  });

  test('buscar series populares use case - Erro', () async {
    when(() => repository.buscarPopular())
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase();

    expect(result.isError(), true);
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
