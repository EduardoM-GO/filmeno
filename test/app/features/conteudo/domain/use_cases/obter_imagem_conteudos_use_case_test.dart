import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/conteudo/domain/use_cases/obter_imagem_conteudos_use_case.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/repositories/imagem_repository.dart';
import 'package:filmeno/app/shared/falha/falha.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockImagemRepository extends Mock implements ImagemRepository {}

final class _ObterImagemConteudosUseCaseTest
    extends ObterImagemConteudosUseCase<Filme> {
  _ObterImagemConteudosUseCaseTest(super.imagemRepository);
}

void main() {
  late ImagemRepository imagemRepository;
  late ObterImagemConteudosUseCase obterImagemConteudosUseCase;

  setUp(() {
    imagemRepository = _MockImagemRepository();
    obterImagemConteudosUseCase =
        _ObterImagemConteudosUseCaseTest(imagemRepository);
  });
  group('obter imagem conteudos use case - getImagemDosConteudos -', () {
    late List<Filme> conteudos;
    late Filme conteudo;
    setUp(() {
      conteudo = Filme.empty();
      conteudos = [conteudo];
    });

    test('Deve retornar uma lista de conteudos com imagem', () async {
      final imagem = Imagem.empty();
      when(() => imagemRepository.obterImagem(conteudo.urlCapa))
          .thenAnswer((_) async => Success(imagem));

      final result =
          await obterImagemConteudosUseCase.getImagemDosConteudos(conteudos);

      expect(result, isA<Success>());
      expect(result.getOrNull(), isA<List>());
      expect(result.getOrNull()!.first, isA<Filme>());
      expect(result.getOrNull()!.first.imagemCapa, imagem);
    });

    test('Deve retornar uma falha ao obter imagem', () async {
      when(() => imagemRepository.obterImagem(conteudo.urlCapa))
          .thenAnswer((_) async => Failure(avisoMock));

      final result =
          await obterImagemConteudosUseCase.getImagemDosConteudos(conteudos);

      expect(result, isA<Failure>());
      expect(result.exceptionOrNull(), isA<Falha>());
    });
  });
}
