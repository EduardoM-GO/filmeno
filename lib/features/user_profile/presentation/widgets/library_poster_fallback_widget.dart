import 'package:flutter/material.dart';

final class LibraryPosterFallbackWidget extends StatelessWidget {
  final ColorScheme colorScheme;

  const LibraryPosterFallbackWidget({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 54,
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.movie_outlined),
    );
  }
}
