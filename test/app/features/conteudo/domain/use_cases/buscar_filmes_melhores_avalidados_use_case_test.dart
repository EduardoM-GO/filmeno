import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_melhores_avalidados_use_case.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeRepository extends Mock implements FilmeRepository {}

void main() {
  late BuscarFilmesMelhoresAvalidadosUseCaseImpl useCase;
  late _MockFilmeRepository repository;

  setUp(() {
    repository = _MockFilmeRepository();
    useCase = BuscarFilmesMelhoresAvalidadosUseCaseImpl(repository);
  });

  test('buscar filmes melhores avaliados use case - Ok', () async {
    const proximaPagina = 1;
    final filmes = [
      Filme.empty().copyWith(codigo: '1', titulo: 'Filme 1'),
      Filme.empty().copyWith(codigo: '2', titulo: 'Filme 2'),
    ];
    final resultado = ResultadoComMetadados(
      resultado: filmes,
      metadados:
          const Metadados(paginaAtual: 1, quantidadePaginaTotal: 2),
    );

    when(() =>
            repository.buscarMelhoresAvalidados(proximaPagina: proximaPagina))
        .thenAnswer((_) async => Success(resultado));

    final result = await useCase(proximaPagina: proximaPagina);

    expect(result.isSuccess(), true);
    expect(result.getOrThrow(), resultado);
  });

  test('buscar filmes melhores avaliados use case - Erro', () async {
    const proximaPagina = 1;
    when(() =>
            repository.buscarMelhoresAvalidados(proximaPagina: proximaPagina))
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase(proximaPagina: proximaPagina);

    expect(result.isError(), true);
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
