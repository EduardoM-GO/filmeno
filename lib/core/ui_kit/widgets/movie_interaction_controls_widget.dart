import 'package:filmeno/core/ui_kit/widgets/control_button_widget.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_enum.dart';
import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:filmeno/features/user_profile/domain/user_interaction_movie.dart';
import 'package:filmeno/features/user_profile/presentation/user_profile_movie_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class MovieInteractionControlsWidget extends ConsumerWidget {
  final int mediaId;
  final MediaTypeEnum mediaType;
  final String title;
  final String posterPath;
  final List<int> genreIds;

  const MovieInteractionControlsWidget({
    super.key,
    required this.mediaId,
    required this.mediaType,
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
          (m) => m.id == mediaId && m.mediaType == mediaType,
          orElse: () => UserInteractionMovie(
              id: mediaId,
              title: '',
              mediaType: mediaType,
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
            mediaId: mediaId,
            mediaType: mediaType,
            title: title,
            posterPath: posterPath,
            genreIds: genreIds,
            newStatus: newStatus,
          );
    }

    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface.withValues(alpha: 0.94),
      elevation: 0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            for (final status in MovieInteractionStatusEnum.allButNone) ...[
              ControlButtonWidget(
                icon: currentStatus == status
                    ? status.iconSelected
                    : status.iconUnselected,
                label: status.label,
                isSelected: currentStatus == status,
                color: status.color,
                onTap: () => updateStatus(currentStatus.getNextStatus(status)),
              ),
              const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }
}
