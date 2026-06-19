import 'package:filmeno/core/ui_kit/widgets/cinema_empty_widget.dart';
import 'package:filmeno/core/ui_kit/widgets/media_type_filter_bar_widget.dart';
import 'package:filmeno/features/movie_search/domain/enums/media_type_filter_enum.dart';
import 'package:filmeno/features/movie_search/presentation/movie_search_notifier.dart';
import 'package:filmeno/features/movie_search/presentation/widgets/search_results_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MovieSearchAnchorWidget extends HookConsumerWidget {
  const MovieSearchAnchorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useSearchController();
    final selectedMediaFilter = useState(MediaTypeFilterEnum.all);

    useEffect(() {
      void onQueryChanged() {
        ref.read(movieSearchProvider.notifier).search(searchController.text);
      }

      searchController.addListener(onQueryChanged);
      return () => searchController.removeListener(onQueryChanged);
    }, [searchController]);

    return SearchAnchor(
      searchController: searchController,
      builder: (context, controller) {
        return IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => controller.openView(),
        );
      },
      suggestionsBuilder: (context, controller) {
        final currentQuery = searchController.text;

        if (currentQuery.trim().length < 2) {
          return [
            MediaTypeFilterBarWidget(selectedFilter: selectedMediaFilter),
            const CinemaEmptyWidget(
              title: 'Digite pelo menos 2 caracteres para buscar.',
              message: '',
              icon: Icons.search,
            ),
          ];
        }

        return [
          MediaTypeFilterBarWidget(selectedFilter: selectedMediaFilter),
          ValueListenableBuilder(
              valueListenable: selectedMediaFilter,
              builder: (context, value, _) {
                return Consumer(
                  builder: (context, ref, _) {
                    final searchAsync = ref.watch(movieSearchProvider);

                    return searchAsync.when(
                      skipLoadingOnRefresh: false,
                      data: (results) {
                        final filteredResults =
                            results.where((result) => value.matches(result.mediaType)).toList();

                        if (filteredResults.isEmpty) {
                          return CinemaEmptyWidget(
                            title: 'Cena não encontrada',
                            message:
                                'Parece que esse título fugiu do nosso roteiro. Tente buscar outro nome!',
                            icon: Icons.search_off,
                          );
                        }

                        return SearchResultsListWidget(results: filteredResults);
                      },
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      error: (err, _) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('Falha ao buscar títulos: $err'),
                        ),
                      ),
                    );
                  },
                );
              }),
        ];
      },
      viewOnOpen: () => searchController.clear(),
    );
  }
}
