import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/status_filter_chip_widget.dart';
import 'package:flutter/material.dart';

final class WatchlistFilterBarWidget extends StatelessWidget {
  final ValueNotifier<MovieInteractionStatusEnum?> selectedFilter;

  const WatchlistFilterBarWidget({super.key, required this.selectedFilter});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          StatusFilterChipWidget(
            label: 'Todos',
            status: null,
            selectedFilter: selectedFilter,
          ),
          const SizedBox(width: 8),
          for (final status in MovieInteractionStatusEnum.allButNone) ...[
            StatusFilterChipWidget(
              label: status.label,
              status: status,
              selectedFilter: selectedFilter,
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
