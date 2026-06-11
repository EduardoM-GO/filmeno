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
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 250),
          firstCurve: Curves.easeInOutCubic,
          secondCurve: Curves.easeInOutCubic,
          sizeCurve: Curves.easeInOutCubic,
          crossFadeState: isExpanded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
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
        const SizedBox(height: 6),
        // Botão de controle
        GestureDetector(
          onTap: () => isExpanded.value = !isExpanded.value,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isExpanded.value ? 'Ler menos' : 'Ler mais',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                // Pequeno detalhe de animação no ícone para acompanhar o texto
                AnimatedRotation(
                  duration: const Duration(milliseconds: 200),
                  turns: isExpanded.value ? 0.5 : 0.0,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
