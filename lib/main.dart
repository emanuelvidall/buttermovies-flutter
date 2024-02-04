import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/Home/top_bar.dart';
import 'package:flutter_application_2/pages/Home/search_bar.dart';
import 'package:flutter_application_2/pages/Home/trending_movies.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '35mm',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '34mm Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> movies = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: topBar(),
        floatingActionButton: FloatingActionButton(onPressed: fetchMovies),
        body: Column(
          children: [
            searchBar(),
            const SizedBox(height: 20),
            trendingMovies(),
          ],
        ));
  }

  void fetchMovies() async {
    final apiKey = dotenv.env['TMDB_API_KEY'];

    debugPrint('fetchMovies called');
    String url = "https://api.themoviedb.org/3/movie/popular?api_key=$apiKey";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      movies = json['results'];
    });
    debugPrint('fetchMovies completed!');
  }
}
