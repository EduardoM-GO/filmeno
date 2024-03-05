import 'package:filmeno/app/features/splash/page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('splash page ...', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SplashPage(),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
