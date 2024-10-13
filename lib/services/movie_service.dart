import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieService {
  Future<List<dynamic>> fetchMovies() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
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
    return movies;
  }

  Future<Map<String, dynamic>> loadMovieDetails(String id) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
    String url = "https://api.themoviedb.org/3/movie/$id?api_key=$apiKey";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    if (response.statusCode == 200) {
      final movieDetails = jsonDecode(body);
      return movieDetails;
    } else {
      throw Exception('Failed to load movies api');
    }
  }

  Future<Map<String, dynamic>> loadMovieCredits(String id) async {
    final apiKey = dotenv.env['TMDB_API_KEY'];
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
      return {'director': directorName, 'actors': filteredActors};
    } else {
      throw Exception('Failed to load movie credits');
    }
  }
}
