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
      // Proceed to Sign Up
      if (profilePic != null &&
          username.isNotEmpty &&
          bio.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        // Store user's Profile Photo
        String profilePicUrl = await StorageService()
            .uploadImageToStorage("profile_pics", profilePic, false);

        // Add user to cloud firestore
        DatabaseService()
            .addUser(cred.user!, profilePicUrl, username, bio, email);
        res = "Success";
      }
    }
    // Firebase Auth Exceptions - weak password / invalid email
    on FirebaseAuthException catch (err) {
      // Email Validation
      if (err.code == 'invalid-email') {
        res = "Invalid/Badly formatted email";
      }

      // Password validation
      else if (err.code == 'weak-password') {
        res = "Password must have at least 6 characters";
      }
    } catch (err) {
      print("Error in signing-in: " + err.toString());
      res = "Error in signing-in";
    }
    return res;
  }

  Future<String> loginWithEmailAndPass(
      {required String email, required String password}) async {
    String res = "";
    try {
      if (email.isEmpty || password.isEmpty) {
        res = "Fields can't be empty";
      } else {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "Success";
      }
    } on FirebaseAuthException catch (err) {
      // Email Validation
      if (err.code == 'invalid-email') {
        res = "Invalid/Badly formatted email";
      }
    } catch (err) {
      print("Error in logging-in: " + err.toString());
      res = "Error in logging-in";
    }
    return res;
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
