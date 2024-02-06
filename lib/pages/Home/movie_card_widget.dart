import 'package:flutter/material.dart';
import '../../models/movie_card.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieCard movie;

  const MovieCardWidget({super.key, required this.movie});
  final imgSize = 'w342';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 20, bottom: 20),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/$imgSize/${movie.imgUrl}"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 320,
        width: 180,
      ),
    );
  }
}
