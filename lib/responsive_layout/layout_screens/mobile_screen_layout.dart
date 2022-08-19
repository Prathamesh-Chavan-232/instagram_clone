import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/services/firestore/firestore.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String username = "";
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void getUserData() async {
    DocumentSnapshot snapshot = await FirestoreMethods().getUserData();
    setState(() {
      username = (snapshot.data() as Map<String, dynamic>)['username'];
    });
    // print(snapshot.data());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: const [
              Padding(
                padding: EdgeInsets.all(12.0),
                child: SignOutButton(),
              ),
            ],
          ),
          body: Center(child: Text('''This is a mobile
                                  Username : $username'''))),
    );
  }
}
