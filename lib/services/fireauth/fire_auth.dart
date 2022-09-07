import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/services/firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/services/firestore/firestore.dart';

class FireAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authState {
    return _auth.authStateChanges();
  }

  Future<String> signUpWithEmailAndPass(
      {required Uint8List profilePic,
      required String username,
      required String bio,
      required String email,
      required String password}) async {
    String res = "Signing-in";
    try {
      //  Signing-in Up
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // Store user's Profile Photo
      String profilePicUrl = await StorageMethods()
          .uploadImageToStorage("profile_pics", profilePic, false);

      // Add user to cloud firestore
      await FirestoreMethods()
          .addUser(cred.user!, profilePicUrl, username, bio, email);
      res = "Success";
    }
    // Firebase Auth Exceptions - weak password / invalid email
    on FirebaseAuthException catch (err) {
      /*
          Note - Dont forget the else condition if checking for specific exceptions
      */
      // Email Validation
      if (err.code == 'invalid-email') {
        res = "Invalid/Badly formatted email";
      }
      // Password validation
      else if (err.code == 'weak-password') {
        res = "Password must have at least 6 characters";
      }
      // Catch all auth exceptions
      else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> loginWithEmailAndPass(
      {required String email, required String password}) async {
    String res = "loggin-in";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "Success";
    } on FirebaseAuthException catch (err) {
      // Email Validation
      if (err.code == 'invalid-email') {
        res = "Invalid/Badly formatted email";
      }
      // Password Validation
      else if (err.code == 'wrong-password') {
        res = "Incorrect password";
      }
      // Catch all other auth exceptions
      else {
        res = err.toString();
      }
    } catch (err) {
      res = err.toString();
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
