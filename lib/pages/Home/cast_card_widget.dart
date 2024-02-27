import 'package:flutter/material.dart';

class CastCardWidget extends StatelessWidget {
  final Map<String, dynamic> cast;
  final imgSize = 'w342';

  const CastCardWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profilePath = cast['profile_path'] ?? '';
    var imageUrl = profilePath.isNotEmpty
        ? "https://image.tmdb.org/t/p/$imgSize/$profilePath"
        : "https://placehold.it/60x60";

    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image:
                  NetworkImage("https://image.tmdb.org/t/p/$imgSize/$imageUrl"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(100),
        ),
        height: 60,
        width: 60,
      ),
    );
  }
}
