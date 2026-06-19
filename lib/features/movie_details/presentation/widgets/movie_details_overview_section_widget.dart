import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

final class MovieDetailsOverviewSectionWidget extends HookWidget {
  final MovieDetails movie;
  const MovieDetailsOverviewSectionWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    final theme = Theme.of(context);

    if (movie.overview.isEmpty) return const SizedBox.shrink();

    final textStyle = theme.textTheme.bodyLarge?.copyWith(
      height: 1.4,
      color: theme.colorScheme.onSurface,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sinopse',
          style:
              theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 250),
          firstCurve: Curves.easeInOutCubic,
          secondCurve: Curves.easeInOutCubic,
          sizeCurve: Curves.easeInOutCubic,
          crossFadeState: isExpanded.value
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Text(
            movie.overview,
            style: textStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.justify,
          ),
          secondChild: Text(
            movie.overview,
            style: textStyle,
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 4),
        TextButton.icon(
          onPressed: () => isExpanded.value = !isExpanded.value,
          icon: AnimatedRotation(
            duration: const Duration(milliseconds: 200),
            turns: isExpanded.value ? 0.5 : 0.0,
            child: const Icon(Icons.keyboard_arrow_down, size: 18),
          ),
          label: Text(isExpanded.value ? 'Ler menos' : 'Ler mais'),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            textStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
