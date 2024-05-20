import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_weather_app/src/core/error/exception.dart';

abstract interface class LoginRemoteDataSource {
  Future<void> loginWithGoogle();
}

class LoginRemoteDateSourceImpl implements LoginRemoteDataSource {
  @override
  Future<void> loginWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint("login Successful");
    } catch (e) {
      debugPrint("login Failed");
      debugPrint(e.toString());
      throw ServerException(e.toString());
    }
  }
}
