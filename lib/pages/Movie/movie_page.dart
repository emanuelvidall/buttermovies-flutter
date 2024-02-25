import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie.dart';
import 'package:flutter_application_2/pages/Home/movie_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MoviePage extends StatefulWidget {
  final Movie movie;

  const MoviePage({Key? key, required this.movie}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

Future<Map<String, dynamic>> fetchMovieDetails(String id) async {
  final apiKey = dotenv.env['TMDB_API_KEY'];
  debugPrint('fetchMovieDetails called');
  String url = "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  if (response.statusCode == 200) {
    final json = jsonDecode(body);
    return json;
  } else {
    throw Exception('Failed to load movies api');
  }
}

// Future<void> fetchAndConvert() async {
//   final jsonResponse = await fetchMovies();

//   List<Movie> movies =
//       jsonResponse.map<Movie>((movieMap) => Movie.fromJson(movieMap)).toList();
//   setState(() {
//     this.movies = movies;
//   });
//   debugPrint('state set');
// }

class _MoviePageState extends State<MoviePage> {
  final backDropSize = 'original';
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
                    'https://image.tmdb.org/t/p/$backDropSize/${widget.movie.backdropUrl}'),
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
                child: GestureDetector(
                    onTap: () {
                      fetchMovieDetails(widget.movie.id.toString());
                    },
                    child: MovieCardWidget(movie: widget.movie)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.movie.title.toString(),
                        style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w900)),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow.shade800,
                            ),
                          ),
                          Text(
                            widget.movie.rating.toStringAsFixed(1),
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
