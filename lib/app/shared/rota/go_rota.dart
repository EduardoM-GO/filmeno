import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

typedef GoPageBuilder = Widget Function(
    BuildContext context, GoRouterState state);
typedef GoInjector = void Function(GetIt getIt)?;

class GoRota extends GoRoute {
  GoRota({
    required super.path,
    GoInjector injector,
    required GoPageBuilder builder,
  }) : super(
          name: path,
          builder: (context, state) {
            if (injector != null && !GetIt.I.hasScope(path)) {
              GetIt.I.pushNewScope(init: injector, scopeName: path);
            }
            return builder(context, state);
          },
          onExit: (context) async {
            await GetIt.I.popScopesTill(path);
            return true;
          },
        );
}
