import 'package:flutter/material.dart';

AppBar topBar() {
  return AppBar(
    backgroundColor: Colors.white,
    toolbarHeight: 100,
    title: Container(
      padding: const EdgeInsets.only(top: 30, left: 5, right: 20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, Emanuel',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xf22b32d1))),
                  SizedBox(height: 6, width: 0),
                  Text(
                    "Let's explore some movies...",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ]),
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile.png'),
                      fit: BoxFit.cover)),
            ),
          ]),
    ),
  );
}
