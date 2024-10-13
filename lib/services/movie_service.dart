import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MovieService {
  Future<List<dynamic>> fetchMovies() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    debugPrint('fetchMovies called');
    String url =
        "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    if (response.statusCode == 200) {
      return json['results'];
    } else {
      throw Exception('Failed to load movies api');
    }
  }

  Future<List<Movie>> fetchAndConvert() async {
    final jsonResponse = await fetchMovies();
    List<Movie> movies = jsonResponse
        .map<Movie>((movieMap) => Movie.fromJson(movieMap))
        .toList();
    debugPrint('movies length');
    debugPrint(movies.length.toString());
    return movies;
  }
}
