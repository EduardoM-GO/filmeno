import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'search_notifier.dart';

class SearchPage extends HookConsumerWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = useTextEditingController();

    final searchState = ref.watch(movieSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Procurar filmes, séries...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Chamamos o notifier a cada mudança.
            // O debounce que criámos no Notifier protegerá a API.
            ref.read(movieSearchProvider.notifier).search(value);
          },
        ),
      ),
      body: searchState.when(
        data: (results) {
          if (results.isEmpty && searchController.text.isNotEmpty) {
            return const Center(child: Text('Nenhum resultado encontrado.'));
          }
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final item = results[index];
              return ListTile(
                title: Text(item.title),
                subtitle: Text(item.mediaType.name),
                leading: item.posterPath.isNotEmpty
                    ? Image.network('https://image.tmdb.org/t/p/w92${item.posterPath}')
                    : const Icon(Icons.movie),
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
