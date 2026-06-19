import 'package:flutter/material.dart';

final class RatingBadgeWidget extends StatelessWidget {
  final double voteAverage;

  const RatingBadgeWidget({super.key, required this.voteAverage});

  @override
  Widget build(BuildContext context) {
    final normalizedRating = voteAverage.toStringAsFixed(1);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.star_rounded, color: Color(0xFFFFD166), size: 16),
            const SizedBox(width: 3),
            Text(
              normalizedRating,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
