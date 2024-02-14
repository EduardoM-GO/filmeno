import 'package:filmeno/app/shared/widgets/tenta_novamente_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('tenta novamente widget ...', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: TentaNovamenteWidget(onTap: () {}),
    ));

    expect(find.byIcon(Icons.refresh), findsNWidgets(1));
    expect(find.byType(IconButton), findsNWidgets(1));
    expect(
        find.byWidgetPredicate(
            (widget) => widget is Center && widget.child is IconButton),
        findsNWidgets(1));
  });
}
