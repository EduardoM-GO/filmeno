import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmeno/core/network/api_config.dart';
import 'package:filmeno/features/movie_details/presentation/movie_details_page.dart';
import 'package:flutter/material.dart';

import '../../domain/trending_movie.dart';

class MovieCard extends StatelessWidget {
  final TrendingMovie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        closedColor: Colors.transparent,
        closedElevation: 0,
        openBuilder: (context, _) => MovieDetailsPage(movieId: movie.id),
        closedBuilder: (context, openContainer) => GestureDetector(
              onTap: openContainer,
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: '${ApiConfig.baseImageUrl}w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color: Colors.black12),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black87, Colors.transparent],
                          ),
                        ),
                        child: Text(
                          movie.title,
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
