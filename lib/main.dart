import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/Home/top_bar.dart';
import 'package:flutter_application_2/pages/Home/search_bar.dart';
import 'package:flutter_application_2/pages/Home/trending_movies.dart';

void main() {
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: topBar(),
        body: Column(
          children: [
            searchBar(),
            SizedBox(
              height: 30,
            ),
            trendingMovies()
          ],
        ));
  }
}
