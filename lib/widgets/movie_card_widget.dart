import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie_model.dart';

class MovieCardWidget extends StatelessWidget {
  final Movie movie;

  const MovieCardWidget({super.key, required this.movie});
  final imgSize = 'w342';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
