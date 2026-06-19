import 'package:filmeno/core/ui_kit/widgets/adaptive_movie_grid_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_error_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_loading_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_page_shell_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/media_type_filter_bar_widget.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_filter_enum.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/movie_search_anchor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'trending_notifier.dart';

class TrendingPageWidget extends HookConsumerWidget {
  const TrendingPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingAsync = ref.watch(trendingMoviesProvider);
    final scrollController = useScrollController();
    final selectedMediaFilter = useState(MediaTypeFilterEnum.all);

    useEffect(() {
      void scrollListener() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9) {
          ref.read(trendingMoviesProvider.notifier).fetchNextPage();
        }
      }

      scrollController.addListener(scrollListener);
      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return AppPageShellWidget(
      title: 'Filmeno',
      subtitle: 'Filmes e séries em alta para começar sua sessão',
      actions: const [MovieSearchAnchorWidget()],
      body: Column(
        children: [
          MediaTypeFilterBarWidget(selectedFilter: selectedMediaFilter),
          Expanded(
            child: trendingAsync.when(
              data: (movies) {
                final filteredMovies = movies
                    .where((movie) =>
                        selectedMediaFilter.value.matches(movie.mediaType))
                    .toList();

                if (filteredMovies.isEmpty) {
                  return const CinemaEmptyWidget(
                    icon: Icons.local_fire_department_outlined,
                    title: 'Nada em cartaz por aqui',
                    message:
                        'Tente outro filtro ou atualize a página para buscar os títulos em alta novamente.',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.read(trendingMoviesProvider.notifier).refresh(),
                  child: AdaptiveMovieGridWidget(
                    controller: scrollController,
                    movies: filteredMovies,
                    showLoadingFooter:
                        selectedMediaFilter.value == MediaTypeFilterEnum.all,
                  ),
                );
              },
              loading: () => const AppLoadingStateWidget(
                  label: 'Buscando títulos em alta...'),
              error: (err, stack) => AppErrorStateWidget(
                error: err,
                onRetry: () =>
                    ref.read(trendingMoviesProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
