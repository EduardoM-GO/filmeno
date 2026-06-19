import 'package:flutter/material.dart';

final class PosterFallbackWidget extends StatelessWidget {
  final ColorScheme colorScheme;

  const PosterFallbackWidget({super.key, required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 75,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.image_not_supported_outlined),
    );
  }
}
