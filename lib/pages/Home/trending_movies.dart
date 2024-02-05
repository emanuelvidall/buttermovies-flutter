import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/Home/movie_card_widget.dart';

class TrendingMovies extends StatelessWidget {
  final List<dynamic> movies;

  const TrendingMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 300,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            'Trending Movies',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            'See All',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(240, 148, 152, 208)),
          )
        ]),
        Expanded(
            child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 20, left: 0, right: 20),
          children: movies.map((movie) {
            return Container(
                margin: const EdgeInsets.only(right: 11),
                child: MovieCardWidget(
                  movie: movie,
                ));
          }).toList(),
        ))
      ]),
    );
  }
}
