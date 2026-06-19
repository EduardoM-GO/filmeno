import 'package:filmeno/features/movie_search/domain/enums/media_type_filter_enum.dart';
import 'package:flutter/material.dart';

final class MediaTypeFilterBarWidget extends StatelessWidget {
  final ValueNotifier<MediaTypeFilterEnum> selectedFilter;
  final EdgeInsetsGeometry padding;

  const MediaTypeFilterBarWidget({
    super.key,
    required this.selectedFilter,
    this.padding = const EdgeInsets.fromLTRB(16, 4, 16, 12),
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: padding,
      child: Row(
        children: [
          for (final filter in MediaTypeFilterEnum.values) ...[
            ValueListenableBuilder(
                valueListenable: selectedFilter,
                builder: (context, value, child) {
                  return FilterChip(
                    label: Text(filter.label),
                    selected: selectedFilter.value == filter,
                    showCheckmark: false,
                    avatar: Icon(
                      switch (filter) {
                        MediaTypeFilterEnum.all => Icons.grid_view_rounded,
                        MediaTypeFilterEnum.movies => Icons.movie_outlined,
                        MediaTypeFilterEnum.series => Icons.live_tv_outlined,
                      },
                      size: 18,
                    ),
                    onSelected: (selected) {
                      if (selected) selectedFilter.value = filter;
                    },
                  );
                }),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
