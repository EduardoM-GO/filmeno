import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeRepository extends Mock implements FilmeRepository {}

class _MockImagemRepository extends Mock implements ImagemRepository {}

void main() {
  late FilmeRepository repository;
  late BuscarFilmesEmCartazUseCaseImpl useCase;

  setUp(() {
    repository = _MockFilmeRepository();
    useCase = BuscarFilmesEmCartazUseCaseImpl(repository, _MockImagemRepository());
  });

  test('BuscarFilmesEmCartazUseCase - Ok', () async {
    final List<Filme> filmes = [];

    when(() => repository.buscarEmCartaz())
        .thenAnswer((_) async => Success(filmes));

    final result = await useCase.call();

    expect(result.isSuccess(), equals(true));
    expect(result.getOrThrow(), isA<List<Filme>>());
    expect(result.getOrThrow(), equals(filmes));
  });

  test('BuscarFilmesEmCartazUseCase - Erro', () async {
    when(() => repository.buscarEmCartaz())
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase.call();

    expect(result.isError(), equals(true));
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
