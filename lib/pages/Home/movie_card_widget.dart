import 'package:flutter/material.dart';
import '../../models/movie_card.dart';

class MovieCardWidget extends StatelessWidget {
  final MovieCard movie;

  const MovieCardWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage('assets/images/toy.jpg'), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(20),
      ),
      height: 300,
      width: 180,
    );
  }
}
