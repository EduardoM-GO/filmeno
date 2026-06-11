import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/features/user_profile/domain/movie_interaction_status_enum.dart';
import 'package:filmeno/features/user_profile/presentation/user_profile_movie_notifier.dart';
import 'package:filmeno/features/user_profile/presentation/widgets/card_profile_watchlist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileWatchlistPage extends HookConsumerWidget {
  const ProfileWatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interactionsAsync = ref.watch(userProfileMovieProvider);

    final selectedFilter = useState<MovieInteractionStatusEnum?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip(
                  context: context,
                  label: 'Todos',
                  status: null,
                  selectedController: selectedFilter,
                ),
                const SizedBox(width: 8),
                for (final status in MovieInteractionStatusEnum.allButNone) ...[
                  _buildFilterChip(
                    context: context,
                    label: status.label,
                    status: status,
                    selectedController: selectedFilter,
                  ),
                  const SizedBox(width: 8),
                ]
              ],
            ),
          ),
          Expanded(
            child: interactionsAsync.when(
              data: (allInteractions) {
                final filteredMovies = selectedFilter.value == null
                    ? allInteractions
                    : allInteractions.where((m) => m.status == selectedFilter.value).toList();

                if (filteredMovies.isEmpty) {
                  return _buildEmptyState(selectedFilter.value);
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: filteredMovies.length,
                  itemBuilder: (context, index) =>
                      CardProfileWatchlistWidget(movie: filteredMovies[index]),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, __) => Center(child: Text('Erro: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required BuildContext context,
    required String label,
    required MovieInteractionStatusEnum? status,
    required ValueNotifier<MovieInteractionStatusEnum?> selectedController,
  }) {
    final isSelected = selectedController.value == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        if (selected) selectedController.value = status;
      },
    );
  }

  Widget _buildEmptyState(MovieInteractionStatusEnum? status) {
    switch (status) {
      case MovieInteractionStatusEnum.watchlist:
        return const CinemaEmptyWidget(
          icon: Icons.bookmark_outline,
          title: 'Sua estante está vazia',
          message: 'Nenhum filme salvo para assistir depois. Explore o app e adicione estreias!',
        );
      case MovieInteractionStatusEnum.like:
        return const CinemaEmptyWidget(
          icon: Icons.thumb_up_outlined,
          title: 'Nenhum joinha por aqui',
          message: 'Marque os filmes que curtiu para treinar o seu motor de recomendações!',
        );
      case MovieInteractionStatusEnum.favorite:
        return const CinemaEmptyWidget(
          icon: Icons.favorite_border,
          title: 'Cadê os filmes do peito?',
          message: 'Selecione os seus favoritos absolutos para ganhar indicações cirúrgicas.',
        );
      case MovieInteractionStatusEnum.dislike:
        return const CinemaEmptyWidget(
          icon: Icons.thumb_down_outlined,
          title: 'Lista limpa!',
          message: 'Você ainda não negativou nenhum filme. Excelente!',
        );
      case null:
        return const CinemaEmptyWidget(
          icon: Icons.movie_filter_outlined,
          title: 'Nenhum filme encontrado',
          message: 'Selecione um filtro para ver os filmes correspondentes.',
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
