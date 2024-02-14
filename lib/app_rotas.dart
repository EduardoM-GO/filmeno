import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

GoRouter get appRotas => GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SizedBox(),
        ),
      ],
    );
