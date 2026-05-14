import 'package:filmeno/features/navigation/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme/dynamic_theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FilmenoApp(),
    ),
  );
}

class FilmenoApp extends ConsumerWidget {
  const FilmenoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Filmeno',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const MainPage(),
    );
  }
}
