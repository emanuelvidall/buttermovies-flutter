import 'package:flutter/material.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 114, 114, 114),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF000000).withOpacity(1),
            offset: Offset(0, 0),
            blurRadius: 5,
            spreadRadius: -2,
          ),
        ],
        color: Colors.blue, // Background color
        borderRadius:
            BorderRadius.circular(16), // Rounded corners with a radius of 16
      ),
      width: screenWidth * 0.8,
      height: screenHeight * 0.5,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center the content vertically
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Username', // Placeholder text for the username field
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          SizedBox(height: 16), // Adds spacing between the two text fields
          TextField(
            obscureText: true, // For password input (hides the text)
            decoration: InputDecoration(
              hintText: 'Password', // Placeholder text for the password field
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
