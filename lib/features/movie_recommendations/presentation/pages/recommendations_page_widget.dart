import 'package:filmeno/core/ui_kit/widgets/adaptive_movie_grid_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_error_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_loading_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_page_shell_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/media_type_filter_bar_widget.dart';
import 'package:filmeno/features/movie_recommendations/presentation/movie_recommendations_notifier.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_filter_enum.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/movie_search_anchor_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final class RecommendationsPageWidget extends HookConsumerWidget {
  const RecommendationsPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendationsAsync = ref.watch(movieRecommendationsProvider);
    final selectedMediaFilter = useState(MediaTypeFilterEnum.all);

    return AppPageShellWidget(
      title: 'Indicações',
      subtitle: 'Escolhas moldadas pelo que você curte',
      actions: const [MovieSearchAnchorWidget()],
      body: Column(
        children: [
          MediaTypeFilterBarWidget(selectedFilter: selectedMediaFilter),
          Expanded(
            child: recommendationsAsync.when(
              data: (movies) {
                final filteredMovies = movies
                    .where((movie) =>
                        selectedMediaFilter.value.matches(movie.mediaType))
                    .toList();

                if (filteredMovies.isEmpty) {
                  return const CinemaEmptyWidget(
                    icon: Icons.psychology_outlined,
                    title: 'Calibrando o Projetor...',
                    message:
                        'Curta ou favorite seus títulos prediletos na tela de detalhes para que o nosso assistente monte uma sessão exclusiva para você!',
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async =>
                      ref.read(movieRecommendationsProvider.notifier).refresh(),
                  child: AdaptiveMovieGridWidget(movies: filteredMovies),
                );
              },
              loading: () => const AppLoadingStateWidget(
                  label: 'Montando suas indicações...'),
              error: (err, __) => AppErrorStateWidget(
                title: 'Não consegui montar suas indicações',
                error: err,
                onRetry: () =>
                    ref.read(movieRecommendationsProvider.notifier).refresh(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
