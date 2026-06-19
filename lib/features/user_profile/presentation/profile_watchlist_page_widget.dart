import 'package:filmeno/core/ui_kit/widgets/app_error_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_loading_state_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/app_page_shell_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/media_type_filter_bar_widget.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_filter_enum.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/movie_search_anchor_widget.dart';
import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:filmeno/features/user_profile/presentation/user_profile_movie_notifier.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/watchlist_filter_bar_widget.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/watchlist_movie_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileWatchlistPageWidget extends HookConsumerWidget {
  const ProfileWatchlistPageWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interactionsAsync = ref.watch(userProfileMovieProvider);

    final selectedFilter = useState<MovieInteractionStatusEnum?>(null);
    final selectedMediaFilter = useState(MediaTypeFilterEnum.all);

    return AppPageShellWidget(
      title: 'Biblioteca',
      subtitle: 'Seu histórico afetivo de filmes e séries',
      actions: const [MovieSearchAnchorWidget()],
      body: Column(
        children: [
          WatchlistFilterBarWidget(selectedFilter: selectedFilter),
          MediaTypeFilterBarWidget(
            selectedFilter: selectedMediaFilter,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          ),
          Expanded(
            child: interactionsAsync.when(
              data: (allInteractions) {
                final filteredMovies = allInteractions.where((interaction) {
                  final matchesStatus = selectedFilter.value == null ||
                      interaction.status == selectedFilter.value;
                  final matchesMedia =
                      selectedMediaFilter.value.matches(interaction.mediaType);

                  return matchesStatus && matchesMedia;
                }).toList();

                if (filteredMovies.isEmpty) {
                  return _buildEmptyState(selectedFilter.value);
                }

                return WatchlistMovieListWidget(movies: filteredMovies);
              },
              loading: () => const AppLoadingStateWidget(
                  label: 'Abrindo sua biblioteca...'),
              error: (err, __) => AppErrorStateWidget(error: err),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(MovieInteractionStatusEnum? status) {
    switch (status) {
      case MovieInteractionStatusEnum.watchlist:
        return const CinemaEmptyWidget(
          icon: Icons.bookmark_outline,
          title: 'Sua estante está vazia',
          message:
              'Nenhum título salvo para assistir depois. Explore o app e adicione estreias!',
        );
      case MovieInteractionStatusEnum.like:
        return const CinemaEmptyWidget(
          icon: Icons.thumb_up_outlined,
          title: 'Nenhum joinha por aqui',
          message:
              'Marque os títulos que curtiu para treinar o seu motor de recomendações!',
        );
      case MovieInteractionStatusEnum.favorite:
        return const CinemaEmptyWidget(
          icon: Icons.favorite_border,
          title: 'Cadê os títulos do peito?',
          message:
              'Selecione os seus favoritos absolutos para ganhar indicações cirúrgicas.',
        );
      case MovieInteractionStatusEnum.dislike:
        return const CinemaEmptyWidget(
          icon: Icons.thumb_down_outlined,
          title: 'Lista limpa!',
          message: 'Você ainda não negativou nenhum título. Excelente!',
        );
      case null:
        return const CinemaEmptyWidget(
          icon: Icons.movie_filter_outlined,
          title: 'Nenhum título encontrado',
          message: 'Selecione um filtro para ver os títulos correspondentes.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
