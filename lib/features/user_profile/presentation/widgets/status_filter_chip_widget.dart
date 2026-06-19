import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:flutter/material.dart';

final class StatusFilterChipWidget extends StatelessWidget {
  final String label;
  final MovieInteractionStatusEnum? status;
  final ValueNotifier<MovieInteractionStatusEnum?> selectedFilter;

  const StatusFilterChipWidget({
    super.key,
    required this.label,
    required this.status,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedFilter.value == status;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      avatar: status == null
          ? const Icon(Icons.grid_view_rounded, size: 18)
          : Icon(status!.iconSelected, size: 18),
      onSelected: (selected) {
        if (selected) selectedFilter.value = status;
      },
    );
  }
}
