import 'package:flutter/material.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () async {
                await AuthService().logOut();
                Navigator.popAndPushNamed(context, "/login");
              },
              child: const Text("Sign-out"),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.grey)),
            ),
          ),
        ],
      ),
      body: const SafeArea(child: Center(child: Text("Instagram Home Page"))),
    );
  }
}
