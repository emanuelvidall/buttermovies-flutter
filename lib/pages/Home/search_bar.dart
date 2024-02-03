import 'package:flutter/material.dart';

Container searchBar() {
  return Container(
    margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
          color: Colors.black.withOpacity(0.11),
          blurRadius: 40,
          spreadRadius: 0.0)
    ]),
    child: TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none),
        hintText: 'Search movies',
        prefixIcon: const Icon(Icons.search),
      ),
    ),
  );
}
