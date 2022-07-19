import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(child :
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: const [
            // App logo image
            // Email Text field
            // Password Text field
            // Forgot & Swtich to Signup
            // Login button
          ],
        ),

      )
      )
    );
  }
}