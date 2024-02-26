import 'package:flutter/material.dart';
import 'package:flutter_application_2/models/cast.dart';

class CastCardWdiget extends StatelessWidget {
  final Cast cast;

  const CastCardWdiget({super.key, required this.cast});

  final imgSize = 'w342';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.tmdb.org/t/p/$imgSize/${cast.avatarUrl}"),
              fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(100),
        ),
        height: 60,
        width: 60,
      ),
    );
  }
}
