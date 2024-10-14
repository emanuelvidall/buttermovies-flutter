import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool _obscureText = true;

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
                    SizedBox(
                      height: 48,
                    )
                  ],
                )),
            Text(
              'Username or Email',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: 'Enter Username or Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14)),
                    hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(
                          0.5), // Set the opacity of the hint text to 50%
                      fontSize: 16.0,
                    ))),
            SizedBox(
              height: 20,
            ),
            Text(
              'Password',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 24),
              child: TextField(
                  obscureText: _obscureText,
                  controller: _passwordController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      labelText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14)),
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(
                            0.5), // Set the opacity of the hint text to 50%
                        fontSize: 16.0,
                      ))),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Divider(
                      color: Colors.black.withOpacity(0.25),
                      thickness: 1,
                    ),
                  ),
                ),
                Text(
                  'or',
                  style: TextStyle(color: Colors.black.withOpacity(0.25)),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Divider(
                      color: Colors.black.withOpacity(0.25),
                      thickness: 1,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [],
            )
          ],
        ),
      ),
    );
  }
}
