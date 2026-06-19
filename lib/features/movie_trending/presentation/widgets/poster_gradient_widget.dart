import 'package:flutter/material.dart';

final class PosterGradientWidget extends StatelessWidget {
  const PosterGradientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black45,
            Colors.transparent,
            Colors.transparent,
            Colors.black87,
          ],
          stops: [0, 0.35, 0.55, 1],
        ),
      ),
    );
  }
}
