import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final FirebaseAuth firebaseAuth;
  Authentication(this.firebaseAuth);

  bool isUserLoggedIn() {
    // function to check wether a user is logged in or not
    if (firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (isUserLoggedIn()) {
      await firebaseAuth.signOut();
      await prefs.clear(); // clears shared preferences
      debugPrint("User Signed Out");
    } else {
      debugPrint("User already logged Out");
    }
  }

  String? currentUserId() {
    // function to get current users id to identify them
    return firebaseAuth.currentUser!.uid;
  }
}
