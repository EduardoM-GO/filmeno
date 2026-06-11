import 'package:flutter/material.dart';

enum MovieInteractionStatusEnum {
  none(
      weight: 0,
      color: Colors.grey,
      iconSelected: Icons.thumb_up_outlined,
      iconUnselected: Icons.thumb_up),
  watchlist(
      weight: 1,
      color: Colors.blue,
      iconSelected: Icons.bookmark,
      iconUnselected: Icons.bookmark_border),
  like(
      weight: 3,
      color: Colors.green,
      iconSelected: Icons.thumb_up,
      iconUnselected: Icons.thumb_up_outlined),
  dislike(
      weight: -5,
      color: Colors.red,
      iconSelected: Icons.thumb_down,
      iconUnselected: Icons.thumb_down_outlined),
  favorite(
      weight: 5,
      color: Colors.pink,
      iconSelected: Icons.favorite,
      iconUnselected: Icons.favorite_border);

  final int weight;
  final Color color;
  final IconData iconSelected;
  final IconData iconUnselected;

  const MovieInteractionStatusEnum(
      {required this.weight,
      required this.color,
      required this.iconSelected,
      required this.iconUnselected});

  static MovieInteractionStatusEnum fromName(String? name) {
    return MovieInteractionStatusEnum.values.firstWhere(
      (e) => e.name == name,
      orElse: () => MovieInteractionStatusEnum.none,
    );
  }

  static Iterable<MovieInteractionStatusEnum> get allButNone =>
      MovieInteractionStatusEnum.values.skip(1);

  MovieInteractionStatusEnum getNextStatus(MovieInteractionStatusEnum novo) =>
      this == novo ? none : novo;

  String get label => switch (this) {
        MovieInteractionStatusEnum.none => '',
        MovieInteractionStatusEnum.watchlist => 'Ver Depois',
        MovieInteractionStatusEnum.like => 'Curti',
        MovieInteractionStatusEnum.dislike => 'Não Curti',
        MovieInteractionStatusEnum.favorite => 'Favorito',
      };
}
