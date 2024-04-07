import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_populares_use_case.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeRepository extends Mock implements FilmeRepository {}

void main() {
  late FilmeRepository repository;
  late BuscarFilmesPopularesUseCaseImpl useCase;

  setUp(() {
    repository = _MockFilmeRepository();
    useCase = BuscarFilmesPopularesUseCaseImpl(repository);
  });

  test('buscar filmes populares use case - Ok', () async {
    final List<Filme> filmes = [Filme.empty()];

    when(() => repository.buscarPopulares())
        .thenAnswer((_) async => Success(filmes));

    final result = await useCase.call();

    expect(result.isSuccess(), equals(true));
    expect(result.getOrThrow(), isA<List<Filme>>());
    expect(result.getOrThrow(), equals(filmes));
  });

  test('buscar filmes populares use case - Erro', () async {
    when(() => repository.buscarPopulares())
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase();

    expect(result.isError(), true);
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
