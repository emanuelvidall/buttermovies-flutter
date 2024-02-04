import 'package:flutter/material.dart';

Container movieCard() {
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
