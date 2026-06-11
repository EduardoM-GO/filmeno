import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:filmeno/features/user_profile/domain/user_interaction_movie.dart';
import 'package:filmeno/features/user_profile/presentation/user_profile_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class MovieInteractionControls extends ConsumerWidget {
  final int movieId;
  final String title;
  final String posterPath;
  final List<int> genreIds;

  const MovieInteractionControls({
    super.key,
    required this.movieId,
    required this.title,
    required this.posterPath,
    required this.genreIds,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(userProfileMovieProvider);

    final currentStatus = profileAsync.maybeWhen(
      data: (interactions) {
        final match = interactions.firstWhere(
          (m) => m.id == movieId,
          orElse: () => UserInteractionMovie(
              id: movieId,
              title: '',
              posterPath: '',
              genreIds: [],
              status: MovieInteractionStatusEnum.none,
              updatedAt: DateTime.now()),
        );
        return match.status;
      },
      orElse: () => MovieInteractionStatusEnum.none,
    );

    void updateStatus(MovieInteractionStatusEnum newStatus) {
      ref.read(userProfileMovieProvider.notifier).updateStatus(
            movieId: movieId,
            title: title,
            posterPath: posterPath,
            genreIds: genreIds,
            newStatus: newStatus,
          );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (final status in MovieInteractionStatusEnum.allButNone)
          _ControlButton(
            icon: currentStatus == status ? status.iconSelected : status.iconUnselected,
            label: status.label,
            isSelected: currentStatus == status,
            color: status.color,
            onTap: () => updateStatus(currentStatus.getNextStatus(status)),
          ),
      ],
    );
  }
}

// Sub-widget de renderização visual pura (estilo "Lego")
class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = isSelected ? color : theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: activeColor, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: activeColor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
