import 'package:flutter/material.dart';
import 'package:instagram_clone/common_utils/colors.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/models/users.dart';
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
    UserModel userData = await FirestoreMethods().getUserData();
    setState(() {
      username = userData.username;
    });
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
          body: username == ""
              ? _loadingUsername()
              : Center(child: Text('Username : $username'))),
    );
  }

  Center _loadingUsername() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Username : '),
          CircularProgressIndicator(color: blueColor)
        ],
      ),
    );
  }
}
