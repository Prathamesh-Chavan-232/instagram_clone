import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/globals.dart';
import 'package:instagram_clone/responsive_layout/layout_screens/mobile_screen_layout.dart';
import 'package:instagram_clone/responsive_layout/responsive_layout.dart';
import 'package:instagram_clone/responsive_layout/layout_screens/web_screen_layout.dart';
import 'package:instagram_clone/screens/auth_pages/login_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDHuOP7EBs6BIDUeN2Q2fq_1_Im-Pt12SY",
      appId: "1:1077591921022:web:8ec2bba3fb6878bca3a32f",
      messagingSenderId: "1077591921022",
      projectId: "instagram-clone-7cd9a",
      storageBucket: "instagram-clone-7cd9a.appspot.com",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_TITLE,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
        // textTheme: DEFAULT_TEXT_THEME
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/start': (context) => const ResponsiveLayout(
              webScreen: WebScreenLayout(),
              mobileScreen: MobileScreenLayout(),
            ),
        '/login' : (context) => const LoginScreen(),
      },
    );
  }
}
