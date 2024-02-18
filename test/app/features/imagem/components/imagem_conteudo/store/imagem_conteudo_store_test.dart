import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/store/imagem_conteudo_store.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../../mock/aviso_mock.dart';

class _MockCallback extends Mock {
  call();
}

class _MockObterImagemUseCase extends Mock implements ObterImagemUseCase {}

void main() {
  late ObterImagemUseCase useCase;
  late _MockCallback callback = _MockCallback();
  late ImagemConteudoStore store;
  late Conteudo conteudo;

  setUp(() {
    useCase = _MockObterImagemUseCase();
    store = ImagemConteudoStore(useCase);
    store.addListener(() => callback.call());
    reset(callback);
    conteudo = const Filme(
        codigo: '',
        titulo: '',
        urlCapa: '',
        avalicaoUsuario: 0,
        favorito: false,
        assistirMaisTarde: false);
  });

  test('imagem conteudo store - ok', () async {
    when(
      () => useCase.call(conteudo.urlCapa),
    ).thenAnswer((invocation) async => Success(Imagem.empty()));

    await store.carregaImagem(conteudo);
    expect(store.state, equals(ImagemConteudoSucessoState(Imagem.empty())));
    verify(() => callback.call()).called(2);
  });
  test('imagem conteudo store - Erro', () async {
    when(
      () => useCase.call(conteudo.urlCapa),
    ).thenAnswer((invocation) async => Failure(avisoMock));

    await store.carregaImagem(conteudo);
    expect(store.state, equals(ImagemConteudoFalhaState()));
    verify(() => callback.call()).called(2);
  });
}
