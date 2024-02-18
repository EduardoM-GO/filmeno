
import 'package:filmeno/app/features/conteudo/domain/entities/conteudo.dart';
import 'package:filmeno/app/features/conteudo/domain/entities/filme.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/imagem_conteudo_component.dart';
import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/imagem_widget.dart';
import 'package:filmeno/app/features/imagem/domain/entities/imagem.dart';
import 'package:filmeno/app/features/imagem/domain/use_cases/obter_imagem_use_case.dart';
import 'package:filmeno/app/shared/widgets/tenta_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../mock/aviso_mock.dart';

class _MockObterImagemUseCase extends Mock implements ObterImagemUseCase {}

void main() {
  late ObterImagemUseCase useCase;
  late Conteudo conteudo;

  setUp(() {
    useCase = _MockObterImagemUseCase();
    GetIt.I.registerFactory<ObterImagemUseCase>(() => useCase);
    conteudo = Filme.empty();
  });

  tearDown(() => GetIt.I.unregister<ObterImagemUseCase>());

  testWidgets('imagem conteudo component - Ok', (tester) async {
    when(
      () => useCase(conteudo.urlCapa),
    ).thenAnswer((invocation) async => Success(Imagem.empty()));

    await tester.pumpWidget(MaterialApp(
      home: ImagemConteudoComponent(conteudo: conteudo),
    ));
    expect(find.byType(CircularProgressIndicator), findsNWidgets(1));
    await tester.pump();
    expect(find.byType(ImagemWidget), findsNWidgets(1));
  });

  testWidgets('imagem conteudo component - Erro', (tester) async {
    when(
      () => useCase(conteudo.urlCapa),
    ).thenAnswer((invocation) async => Failure(avisoMock));

    await tester.pumpWidget(MaterialApp(
      home: ImagemConteudoComponent(conteudo: conteudo),
    ));
    expect(find.byType(CircularProgressIndicator), findsNWidgets(1));
    await tester.pump();
    expect(find.byType(TentaNovamenteWidget), findsNWidgets(1));
  });

  testWidgets('imagem conteudo component - Erro - tentando novamente',
      (tester) async {
    int chamadoUseCase = 0;
    when(
      () => useCase(conteudo.urlCapa),
    ).thenAnswer((invocation) async {
      chamadoUseCase++;
      return chamadoUseCase > 1 ? Success(Imagem.empty()) : Failure(avisoMock);
    });

    await tester.pumpWidget(MaterialApp(
      home: ImagemConteudoComponent(conteudo: conteudo),
    ));
    expect(find.byType(CircularProgressIndicator), findsNWidgets(1));
    await tester.pump();
    expect(find.byType(TentaNovamenteWidget), findsNWidgets(1));
    await tester.tap(find.byType(IconButton));

    await tester.pumpAndSettle();
    expect(find.byType(ImagemWidget), findsNWidgets(1));
  });
}
