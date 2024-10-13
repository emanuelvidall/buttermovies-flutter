import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/top_bar.dart';
import 'package:flutter_application_2/widgets/search_bar.dart';
import 'package:flutter_application_2/widgets/trending_movies.dart';
import 'package:flutter_application_2/models/movie_model.dart';
import 'package:flutter_application_2/services/movie_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MovieService _movieService = MovieService();
  List<Movie> movies = [];
  @override
  void initState() {
    super.initState();
    fetchMoviesAndSetState();
  }

  Future<void> fetchMoviesAndSetState() async {
    List<Movie> fetchedMovies = await _movieService.fetchAndConvert();
    setState(() {
      movies = fetchedMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: topBar(),
        body: Column(
          children: [
            searchBar(),
            const SizedBox(height: 40),
            TrendingMoviesWidget(movies: movies),
            const SizedBox(height: 40),
          ],
        ));
  }
}
