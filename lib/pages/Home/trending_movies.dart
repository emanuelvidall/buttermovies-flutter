import 'package:flutter/material.dart';

Container trendingMovies() {
  return Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    height: 300,
    color: Colors.red,
    child: Column(children: [
      Expanded(
          child: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            color: Colors.amber[600],
            child: const Center(child: Text('Entry A')),
          ),
          Container(
            height: 50,
            width: 50,
            color: Colors.amber[500],
            child: const Center(child: Text('Entry B')),
          ),
          Container(
            height: 50,
            width: 50,
            color: Colors.amber[100],
            child: const Center(child: Text('Entry C')),
          ),
        ],
      ))
    ]),
  );
}
