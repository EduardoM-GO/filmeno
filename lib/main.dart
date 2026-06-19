import 'package:filmeno/features/navigation/presentation/main_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/theme/dynamic_theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FilmenoAppWidget(),
    ),
  );
}

class FilmenoAppWidget extends ConsumerWidget {
  const FilmenoAppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(appThemeProvider);

    return MaterialApp(
      title: 'Filmeno',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: const MainPageWidget(),
    );
  }
}
