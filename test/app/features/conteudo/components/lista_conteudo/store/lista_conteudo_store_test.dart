import 'package:filmeno/app/features/conteudo/components/lista_conteudo/store/lista_conteudo_store.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
import 'package:filmeno/app/shared/domain/entities/metadados.dart';
import 'package:filmeno/app/shared/domain/entities/resultado_com_metadados.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../mock/aviso_mock.dart';

class _MockCallback extends Mock {
  call();
}

class _MockBuscarFilmesEmCartazUseCase extends Mock
    implements BuscarFilmesEmCartazUseCase {}

void main() {
  late BuscarFilmesEmCartazUseCase useCase;
  late _MockCallback callback;
  late ListaConteudoStore listaConteudoStore;
  late List<Filme> filmes;

  setUp(() {
    useCase = _MockBuscarFilmesEmCartazUseCase();
    listaConteudoStore = ListaConteudoStore(useCase.call);
    callback = _MockCallback();
    listaConteudoStore.addListener(() => callback.call());
    reset(callback);
    filmes = List.generate(10, (index) => Filme.empty());
  });

  group('lista conteudo store - buscarConteudos - Ok - ', () {
    test('Todos conteudos carregado', () async {
      when(
        () => useCase.call(proximaPagina: null),
      ).thenAnswer((invocation) async => Success(ResultadoComMetadados(
            metadados:
                const Metadados(paginaAtual: 1, quantidadePaginaTotal: 1),
            resultado: filmes,
          )));

      await listaConteudoStore.buscarConteudos();
      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
            conteudos: filmes,
            carregamentoCompleto: true,
          )));
      verify(() => callback.call()).called(2);
    });

    test('Primeira pagina conteudos carregado', () async {
      when(
        () => useCase.call(proximaPagina: null),
      ).thenAnswer((invocation) async => Success(ResultadoComMetadados(
            metadados:
                const Metadados(paginaAtual: 1, quantidadePaginaTotal: 2),
            resultado: filmes,
          )));

      await listaConteudoStore.buscarConteudos();
      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
            conteudos: filmes,
            carregamentoCompleto: false,
          )));
      verify(() => callback.call()).called(2);
    });

    test('Carrega todas as paginas do conteudos', () async {
      when(
        () => useCase.call(proximaPagina: null),
      ).thenAnswer((invocation) async => Success(ResultadoComMetadados(
            metadados:
                const Metadados(paginaAtual: 1, quantidadePaginaTotal: 2),
            resultado: filmes,
          )));

      await listaConteudoStore.buscarConteudos();
      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
              conteudos: filmes, carregamentoCompleto: false)));
      verify(() => callback.call()).called(2);

      when(
        () => useCase.call(proximaPagina: 2),
      ).thenAnswer((invocation) async => Success(ResultadoComMetadados(
            metadados:
                const Metadados(paginaAtual: 2, quantidadePaginaTotal: 2),
            resultado: filmes,
          )));

      await listaConteudoStore.buscarConteudos();
      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
              conteudos: [...filmes, ...filmes], carregamentoCompleto: true)));
      verify(() => callback.call()).called(2);
    });

    test('Buscar com todos os dados carregados', () async {
      when(
        () => useCase.call(proximaPagina: null),
      ).thenAnswer((invocation) async => Success(ResultadoComMetadados(
            metadados:
                const Metadados(paginaAtual: 1, quantidadePaginaTotal: 1),
            resultado: filmes,
          )));

      await listaConteudoStore.buscarConteudos();

      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
              conteudos: filmes, carregamentoCompleto: true)));
      verify(() => callback.call()).called(2);

      await listaConteudoStore.buscarConteudos();

      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
              conteudos: filmes, carregamentoCompleto: true)));
      verifyNever(() => callback.call()).called(0);
    });

    test('Retorno vazio', () async {
      when(
        () => useCase.call(proximaPagina: null),
      ).thenAnswer((invocation) async => const Success(ResultadoComMetadados(
            metadados: Metadados(paginaAtual: 1, quantidadePaginaTotal: 2),
            resultado: [],
          )));

      await listaConteudoStore.buscarConteudos();

      expect(
          listaConteudoStore.state,
          equals(ListaConteudoSucessoState(
              conteudos: const [], carregamentoCompleto: true)));
      verify(() => callback.call()).called(2);
    });
  });

  test('lista conteudo store - buscarConteudos - Erro', () async {
    when(
      () => useCase.call(proximaPagina: null),
    ).thenAnswer((invocation) async => Failure(avisoMock));

    await listaConteudoStore.buscarConteudos();
    expect(listaConteudoStore.state, equals(ListaConteudoFalhaState()));
    verify(() => callback.call()).called(2);
  });
}
