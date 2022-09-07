import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/users.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';

class FirestoreMethods {
  final _db = FirebaseFirestore.instance;

  Future addUser(User user, String profilePicUrl, String username, String bio,
      String email) async {
    UserModel userModel = UserModel(
      profilePicUrl: profilePicUrl,
      username: username,
      uid: user.uid,
      email: email,
      bio: bio,
      followers: [],
      following: [],
    );
    await _db.collection('users').doc(user.uid).set(userModel.toJson());
  }

  Future<UserModel> getUserData() async {
    final User currentUser = FireAuth().getCurrentUser()!;
    DocumentSnapshot snap =
        await _db.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnap(snap);
  }
}
