import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/repositories/filme_repository.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_proximas_estreias_use_case.dart';
import 'package:filmeno/app/shared/domain/entities/metadados_http.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockFilmeRepository extends Mock implements FilmeRepository {}

void main() {
  late FilmeRepository repository;
  late BuscarFilmesProximasEstreiasUseCaseImpl useCase;

  setUp(() {
    repository = _MockFilmeRepository();
    useCase = BuscarFilmesProximasEstreiasUseCaseImpl(repository);
  });

  test('buscar filmes próximas estreias use case - Ok', () async {
    final filmes = [
      Filme.empty().copyWith(codigo: '1', titulo: 'Filme 1'),
      Filme.empty().copyWith(codigo: '2', titulo: 'Filme 2'),
    ];
    final resultado = ResultadoComMetadados(
      resultado: filmes,
      metadados: const MetadadosHttp(paginaAtual: 1, quantidadePaginaTotal: 2),
    );

    when(() => repository.buscarProximasEstreias(proximaPagina: 1))
        .thenAnswer((_) async => Success(resultado));

    final result = await useCase(proximaPagina: 1);

    expect(result.isSuccess(), true);
    expect(result.getOrThrow(), resultado);
  });

  test('buscar filmes próximas estreias use case - Erro', () async {
    when(() => repository.buscarProximasEstreias(proximaPagina: 1))
        .thenAnswer((_) async => Failure(avisoMock));

    final result = await useCase(proximaPagina: 1);

    expect(result.isError(), true);
    expect(result.exceptionOrNull(), isA<Falha>());
  });
}
