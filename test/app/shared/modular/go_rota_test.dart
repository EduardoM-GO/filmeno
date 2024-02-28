import 'package:filmeno/app/shared/modular/go_rota.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

void main() {
  late List<GoRota> rotas;

  setUp(() {
    rotas = [
      GoRota(
        path: '/',
        builder: (_, state) => const Center(
          child: Text('Inicio'),
        ),
      ),
    ];
  });

  testWidgets('go rota - injector', (tester) async {
    rotas.add(GoRota(
      path: '/go-rota',
      injector: (getIt) {
        getIt.registerSingleton<String>('go-rota-injector');
      },
      builder: (context, state) => Column(
        children: [
          Text(GetIt.I.get<String>()),
          TextButton(
              onPressed: () => context.pushReplacementNamed('/'),
              child: const Text('Voltar'))
        ],
      ),
    ));

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(routes: rotas, initialLocation: '/go-rota'),
      ),
    );

    expect(GetIt.I.hasScope('/go-rota'), isTrue);
    expect(GetIt.I.isRegistered<String>(), isTrue);
    expect(find.text('go-rota-injector'), findsOneWidget);

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(GetIt.I.isRegistered<String>(), isFalse);
    expect(GetIt.I.hasScope('/go-rota'), isFalse);
  });

  testWidgets('go rota - sem injecto', (tester) async {
    rotas.add(GoRota(
      path: '/go-rota',
      builder: (context, state) => Column(
        children: [
          TextButton(
              onPressed: () => context.pushReplacementNamed('/'),
              child: const Text('Voltar'))
        ],
      ),
    ));

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: GoRouter(routes: rotas, initialLocation: '/go-rota'),
      ),
    );

    expect(GetIt.I.hasScope('/go-rota'), isFalse);

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.text('Inicio'), findsOneWidget);
    expect(GetIt.I.hasScope('/go-rota'), isFalse);
  });
}
