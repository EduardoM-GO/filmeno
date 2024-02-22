import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/percentual_nota_conteudo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('percentual nota conteudo widget - ok', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PercentualNotaConteudoWidget(
        avaliacaoUsuario: 10.0,
      ),
    ));

    expect(find.byType(TweenAnimationBuilder<double>), findsNWidgets(1));
    expect(find.text('0%'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('10%'), findsOneWidget);
  });
  testWidgets('percentual nota conteudo widget - Atualiza avaliacao usuario',
      (tester) async {
    final ValueNotifier<double> avaliacaoUsuario = ValueNotifier<double>(10);

    await tester.pumpWidget(MaterialApp(
      home: ValueListenableBuilder(
        valueListenable: avaliacaoUsuario,
        builder: (context, value, _) => PercentualNotaConteudoWidget(
          avaliacaoUsuario: value,
        ),
      ),
    ));

    expect(find.byType(TweenAnimationBuilder<double>), findsNWidgets(1));
    expect(find.text('0%'), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.text('10%'), findsOneWidget);
    avaliacaoUsuario.value = 20;
    await tester.pumpAndSettle();
    expect(find.text('20%'), findsOneWidget);
  });
}
