import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final _db = FirebaseFirestore.instance;

  Future addUser(User user, String username, String bio, String email) async {
    await _db.collection('users').doc(user.uid).set({
      'username': username,
      'email': email,
      'bio': bio,
      'uid': user.uid,
      'followers': [],
      'following': [],
    });
  }
}
