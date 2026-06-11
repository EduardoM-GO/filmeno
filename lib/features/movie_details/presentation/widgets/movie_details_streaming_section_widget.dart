import 'package:filmeno/features/movie_details/domain/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final class MovieDetailsStreamingSectionWidget extends StatelessWidget {
  final MovieDetails movie;
  const MovieDetailsStreamingSectionWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Disponível em:", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.streamingProviders.length,
            itemBuilder: (context, i) {
              final provider = movie.streamingProviders[i];
              return InkWell(
                onTap: () async {
                  final url = Uri.parse(movie.watchLink);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original${provider.logoPath}',
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
