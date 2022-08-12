import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/services/firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/services/firestore/firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUpWithEmailAndPass(
      {required Uint8List? profilePic,
      required String username,
      required String bio,
      required String email,
      required String password}) async {
    String res = "All Fields are required";
    try {
      // Validate for Profile pic not selected
      if (profilePic == null) {
        res = "Please Select Profile Photo";
      }

      // Validate for empty Textfields
      else if (username.isEmpty ||
          bio.isEmpty ||
          email.isEmpty ||
          password.isEmpty) {
        res = "Fields can't be empty";
      }

      // Proceed to Sign Up
      else {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Store user's Profile Photo
        String profilePicUrl = await StorageService()
            .uploadImageToStorage("profile_pics", profilePic, false);

        // Add user to cloud firestore
        DatabaseService()
            .addUser(cred.user!, profilePicUrl, username, bio, email);
        res = "User created successfully";
      }

      return res;
    } catch (err) {
      print("Error in Signing-up : $err");
      return err.toString();
    }
  }

  Future loginWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        return cred.user!;
      }
    } catch (err) {
      print("Error in logging-in : $err");
      return null;
    }
  }

  Future logOut() async {
    try {
      await _auth.signOut();
    } catch (err) {
      print("Error in signing-out : $err");
    }
  }

  User? getCurrentUser() {
    User? res = _auth.currentUser;
    return res;
  }
}
