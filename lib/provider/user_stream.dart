import 'package:flutter/widgets.dart';
import 'package:instagram_clone/models/users.dart';

class UserStream with ChangeNotifier {
  UserModel? _user;
  UserModel get getUserData => _user!;

  Future refreshUser() async {}
}
