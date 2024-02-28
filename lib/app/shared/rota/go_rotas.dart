import 'package:filmeno/app/shared/rota/go_rota.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

part 'rotas.dart';

class GoRotas extends GoRouter {
  GoRotas()
      : super.routingConfig(
          routingConfig: ValueNotifier(
            RoutingConfig(routes: rotas, redirectLimit: 5),
          ),
          routerNeglect: false,
          overridePlatformDefaultLocation: false,
          debugLogDiagnostics: false,
          requestFocus: true,
        );
}
