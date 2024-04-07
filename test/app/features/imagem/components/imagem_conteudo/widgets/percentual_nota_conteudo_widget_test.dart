import 'package:filmeno/app/features/imagem/components/imagem_conteudo/widgets/percentual_nota_conteudo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('percentual nota conteudo widget - ok', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PercentualNotaConteudoWidget(
        avaliacaoUsuario: 0.10,
      ),
    ));

    await tester.pumpAndSettle();
    expect(find.text('10%'), findsOneWidget);
  });
}
