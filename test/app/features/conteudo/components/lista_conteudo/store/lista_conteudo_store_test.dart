import 'package:filmeno/app/features/conteudo/components/lista_conteudo/store/lista_conteudo_store.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/buscar_filmes_em_cartaz_use_case.dart';
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
        () => useCase(),
      ).thenAnswer((invocation) async => Success(filmes));

      await listaConteudoStore.buscarConteudos();
      expect(
          listaConteudoStore.state, equals(ListaConteudoSucessoState(filmes)));
      verify(() => callback.call()).called(2);
    });

    test('Retorno vazio', () async {
      when(
        () => useCase(),
      ).thenAnswer((invocation) async => const Success(
            [],
          ));

      await listaConteudoStore.buscarConteudos();

      expect(listaConteudoStore.state,
          equals(ListaConteudoSucessoState(const [])));
      verify(() => callback.call()).called(2);
    });
  });

  test('lista conteudo store - buscarConteudos - Erro', () async {
    when(
      () => useCase(),
    ).thenAnswer((invocation) async => Failure(avisoMock));

    await listaConteudoStore.buscarConteudos();
    expect(listaConteudoStore.state, equals(ListaConteudoFalhaState()));
    verify(() => callback.call()).called(2);
  });
}
