import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive_layout/layout_screens/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive_layout/layout_screens/web_screen_layout.dart';
import 'package:instagram_clone/responsive_layout/responsive_layout.dart';
import 'package:instagram_clone/screens/auth_pages/login_screen.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';

class CheckAuth extends StatelessWidget {
  const CheckAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool showSignIn = FireAuth().getCurrentUser() == null ? true : false;
    return showSignIn
        ? const LoginScreen()
        : const ResponsiveLayout(
            webScreen: WebScreenLayout(),
            mobileScreen: MobileScreenLayout(),
          );
  }
}
