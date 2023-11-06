import 'package:filmeno/app/shared/theme/color_schemes.g.dart';
import 'package:filmeno/app/shared/theme/theme_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Filmeno',
      theme: themeCustom(colorScheme: darkColorScheme),
      routerConfig: Modular.routerConfig,
    );
  }
}
