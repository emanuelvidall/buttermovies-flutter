import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie.dart';
import 'package:flutter_application_2/pages/Home/movie_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviePage extends StatelessWidget {
  final Movie movie;

  const MoviePage({Key? key, required this.movie}) : super(key: key);

  final backDropSize = 'original';
  //example: 'w342', 'w500'
  final imgUrlSize = 'w342';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/$backDropSize/${movie.backdropUrl}'),
                fit: BoxFit.cover,
              )),
              child: Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.8),
                ], stops: [
                  0.1,
                  0.5
                ], begin: Alignment.topRight, end: Alignment.bottomRight),
              ))),
          Container(
            padding: const EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 15,
                      offset: const Offset(0, 0))
                ]),
                child: MovieCardWidget(movie: movie),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        movie.title.toString(),
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w900)),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow.shade800,
                            ),
                          ),
                          Text(
                            movie.rating.toStringAsFixed(1),
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
