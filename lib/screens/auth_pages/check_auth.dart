import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/auth_pages/login_screen.dart';
import 'package:instagram_clone/screens/home_page/home.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showSignIn = AuthService().getCurrentUser() == null ? true : false;
    return showSignIn ? const LoginScreen() : const HomePage();
  }
}
