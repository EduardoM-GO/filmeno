import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dynamic_theme_provider.g.dart';

@riverpod
class AppTheme extends _$AppTheme {
  @override
  ThemeData build() {
    // Tema inicial padrão
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.deepPurple,
      brightness: Brightness.dark,
    );
  }

  void updateThemeFromImage(ImageProvider image) async {
    final colorScheme = await ColorScheme.fromImageProvider(
      provider: image,
      brightness: Brightness.dark,
    );

    state = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
    );
  }
}
