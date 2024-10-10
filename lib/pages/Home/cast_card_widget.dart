import 'package:flutter/material.dart';

class CastCardWidget extends StatelessWidget {
  final Map<String, dynamic> cast;
  final imgSize = 'w342';

  const CastCardWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var actorName = cast['name'] ?? '';
    var profilePath = cast['profile_path'] ?? '';
    var imageUrl = profilePath.isNotEmpty
        ? "https://image.tmdb.org/t/p/$imgSize/$profilePath"
        : "https://placehold.it/60x60"; // Placeholder image URL if no profile path

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(imageUrl), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(100)),
          width: 60,
          height: 60,
        ),
        const SizedBox(height: 10),
        Text(
          actorName,
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
