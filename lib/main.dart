import 'package:filmeno/app/shared/theme/color_schemes.g.dart';
import 'package:filmeno/app/shared/theme/theme_custom.dart';
import 'package:filmeno/app_rotas.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp.router(
    title: 'Filmeno',
    theme: themeCustom(colorScheme: darkColorScheme),
    routerConfig: appRotas,
  ));
}
