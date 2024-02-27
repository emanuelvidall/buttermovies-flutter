import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie.dart';
import 'package:flutter_application_2/pages/Home/cast_card_widget.dart';
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

class _MoviePageState extends State<MoviePage> {
  List<Map<String, dynamic>> atores = [];
  Map<String, dynamic>? movieDetails;
  Map<String, dynamic>? movieCredits;
  String? movieDirector = '';
  Future<List<Map<String, dynamic>>>? _movieCreditsFuture;

  @override
  void initState() {
    super.initState();
    _loadMovieDetails(widget.movie.id.toString());
    _movieCreditsFuture = _loadMovieCredits(widget.movie.id.toString());
  }

  Future<Map<String, dynamic>> _loadMovieDetails(String id) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    debugPrint('fetchMovieDetails called on mount');
    String url = "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final json = jsonDecode(body);
      setState(() {
        movieDetails = json;
      });
      return json;
    } else {
      throw Exception('Failed to load movies api');
    }
  }

  Future<List<Map<String, dynamic>>> _loadMovieCredits(String id) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    debugPrint('_loadMovieCredits called on mount');
    String url =
        'https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final json = jsonDecode(body);

      final List<dynamic> crew = json['crew'];
      String? directorName;
      for (var member in crew) {
        if (member['job'] == 'Director') {
          directorName = member['name'];
        }
      }

      final List<Map<String, dynamic>> filteredActors = [];
      final List<dynamic> actors = json['cast'];
      for (var member in actors) {
        if (filteredActors.length >= 5) {
          break;
        }
        if (member['known_for_department'] == 'Acting') {
          filteredActors.add(
              {'name': member['name'], 'profile_path': member['profile_path']});
        }
      }

      setState(() {
        atores = filteredActors;
      });

      if (directorName != null) {
        setState(() {
          movieDirector = directorName;
        });
      }
      return filteredActors;
    } else {
      throw Exception('Failed to load movie credits');
    }
  }

  final backDropSize = 'original';
  final imgUrlSize = 'w342';

  @override
  Widget build(BuildContext context) {
    String overviewText = movieDetails?['overview'] ?? 'No overview available';
    String runtimeHours;
    String runtimeMinutes;
    if (movieDetails?['runtime'] != null) {
      int hours = (movieDetails?['runtime'] / 60).floor();
      runtimeHours = hours.toString();
    } else {
      runtimeHours = ' ';
    }
    if (movieDetails?['runtime'] != null) {
      int minutes = (movieDetails?['runtime'] % 60).floor();
      runtimeMinutes = minutes.toString();
    } else {
      runtimeMinutes = ' ';
    }

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
                      _loadMovieDetails(widget.movie.id.toString());
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
              ),
              Container(
                padding: const EdgeInsets.only(left: 30, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(children: [
                      Text(runtimeHours +
                          'hr ' +
                          runtimeMinutes +
                          'min' +
                          "| " +
                          "Director: " +
                          movieDirector.toString())
                    ]),
                    const SizedBox(height: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text('Prolog',
                          style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900))),
                    ),
                    Text(
                      overviewText,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                    FutureBuilder<List<Map<String, dynamic>>>(
                      future: _movieCreditsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(); // Show loading indicator
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          // Data is loaded:
                          var castList = snapshot.data ??
                              []; // Fallback to empty list if null
                          return ListView.builder(
                            itemCount: castList.length,
                            itemBuilder: (context, index) {
                              return CastCardWidget(cast: castList[index]);
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
