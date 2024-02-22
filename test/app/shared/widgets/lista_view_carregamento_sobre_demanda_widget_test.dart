import 'package:filmeno/app/shared/widgets/lista_view_carregamento_sobre_demanda_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //Todo Corrigir teste
  testWidgets(
      'Teste de renderização da ListaViewCarregamentoSobreDemandaWidget',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ListaViewCarregamentoSobreDemandaWidget<String>(
          dados: const ['Item 1', 'Item 2', 'Item 3'],
          carregamentoCompleto: true,
          cardDados: (String dado) => Text(dado),
          carregarMaisDados: () {},
          scrollDirection: Axis.vertical,
        ),
      ),
    );

    expect(find.text('Item 1'), findsOneWidget);
    expect(find.text('Item 2'), findsOneWidget);
    expect(find.text('Item 3'), findsOneWidget);

    // Verifique se o indicador de carregamento não está presente, já que todos os dados foram carregados
    // expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
