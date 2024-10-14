import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  Future<void> _handleLogin() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final result = await _authService.login(username, password);
      debugPrint('Login successfull: $result');
    } catch (e) {
      debugPrint('Login failed $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's Sign you in.",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            Opacity(
                opacity: 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      'Welcome back',
                      style: TextStyle(fontSize: 26),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "You've been missed!",
                      style: TextStyle(fontSize: 26),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
