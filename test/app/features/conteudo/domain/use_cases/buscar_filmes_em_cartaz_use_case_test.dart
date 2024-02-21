import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeRepository extends Mock implements FilmeRepository {}

void main() {
  late FilmeRepository repository;
  late BuscarFilmesEmCartazUseCaseImpl useCase;

  setUp(() {
    repository = _MockFilmeRepository();
    useCase = BuscarFilmesEmCartazUseCaseImpl(repository);
  });

  test('BuscarFilmesEmCartazUseCase - Ok', () async {
    final ResultadoComMetadados<List<Filme>> filmes = ResultadoComMetadados(
        metadados:
            const Metadados(paginaAtual: 1, quantidadePaginaTotal: 2),
        resultado: [Filme.empty()]);

    when(() => repository.buscarEmCartaz(proximaPagina: 1))
        .thenAnswer((_) async => Success(filmes));

    final result = await useCase.call(proximaPagina: 1);

    expect(result.isSuccess(), equals(true));
    expect(result.getOrThrow(), isA<ResultadoComMetadados<List<Filme>>>());
    expect(result.getOrThrow(), equals(filmes));
  });

  test('BuscarFilmesEmCartazUseCase - Erro', () async {
    when(() => repository.buscarEmCartaz(proximaPagina: 1))
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase.call(proximaPagina: 1);

    expect(result.isError(), equals(true));
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
