import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/login_form_widget.dart';
import 'package:flutter_application_2/widgets/login_welcome_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Colors.white),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [LoginWelcomeWidget()],
          )
        ],
      ),
    );
  }
}
