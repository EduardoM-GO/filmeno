import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';

final class MovieDetailsHeaderWidget extends StatelessWidget {
  final MovieDetails movie;

  const MovieDetailsHeaderWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        titlePadding: const EdgeInsetsDirectional.only(start: 16, bottom: 16, end: 64),
        centerTitle: false,
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: movie.backdropPath,
              child: CachedNetworkImage(
                imageUrl: '${ApiConfig.baseImageUrl}w780${movie.backdropPath}',
                fit: BoxFit.cover,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Theme.of(context).colorScheme.surfaceContainerLow],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
