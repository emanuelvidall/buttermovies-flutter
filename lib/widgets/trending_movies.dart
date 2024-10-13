import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie_model.dart';
import 'package:flutter_application_2/widgets/movie_card_widget.dart';
import 'package:flutter_application_2/screens/movie_page.dart';

class TrendingMovies extends StatelessWidget {
  final List<Movie> movies;

  const TrendingMovies({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 340,
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
            child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 30),
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MoviePage(movie: movies[index])));
                },
                child: MovieCardWidget(movie: movies[index]));
          },
        ))
      ]),
    );
  }
}
