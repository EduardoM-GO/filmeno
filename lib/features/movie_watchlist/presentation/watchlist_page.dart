import 'package:filmeno/core/network/api_config.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'watchlist_notifier.dart';

final class WatchlistPage extends ConsumerWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchlistAsync = ref.watch(watchlistProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Minha Lista')),
      body: watchlistAsync.when(
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(child: Text('Nenhum filme guardado.'));
          }
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(
                  '${ApiConfig.baseImageUrl}w92${movie['poster_path']}',
                  errorBuilder: (_, __, ___) => const Icon(Icons.movie),
                ),
                title: Text(movie['title']),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () {
                    ref.read(watchlistProvider.notifier).toggleMovie(movie);
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }
}
