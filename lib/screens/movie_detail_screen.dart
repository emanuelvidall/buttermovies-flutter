import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/movie_model.dart';
import 'package:flutter_application_2/widgets/cast_card_widget.dart';
import 'package:flutter_application_2/widgets/movie_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_2/services/movie_service.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;
  const MoviePage({super.key, required this.movie});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  Map<String, dynamic>? movieDetails;
  Map<String, dynamic>? movieCredits;
  String? movieDirector = '';
  final MovieService _movieService = MovieService();
  Future<Map<String, dynamic>>? _movieCreditsFuture;

  @override
  void initState() {
    super.initState();
    _movieCreditsFuture =
        _movieService.loadMovieCredits(widget.movie.id.toString());

    _fetchMovieDetailsAndCredits();
  }

  Future<void> _fetchMovieDetailsAndCredits() async {
    try {
      final details =
          await _movieService.loadMovieDetails(widget.movie.id.toString());
      final credits =
          await _movieService.loadMovieCredits(widget.movie.id.toString());
      setState(() {
        movieDetails = details;
        movieDirector = credits['director'];
        // movieCredits = credits;
      });
    } catch (e) {
      debugPrint('Error fetching movie details: $e');
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
                ], stops: const [
                  0.1,
                  0.5
                ], begin: Alignment.topRight, end: Alignment.bottomRight),
              ))),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
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
                      _movieService
                          .loadMovieDetails(widget.movie.id.toString());
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
                    const SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _movieCreditsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          var castList = snapshot.data?['actors'] ?? [];
                          return SizedBox(
                            height: 90,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: castList.length,
                              itemBuilder: (context, index) {
                                return CastCardWidget(cast: castList[index]);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 20),
                            ),
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
