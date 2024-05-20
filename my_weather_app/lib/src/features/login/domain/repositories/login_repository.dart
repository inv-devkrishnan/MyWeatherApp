import 'package:firebase_auth/firebase_auth.dart';

abstract interface class LoginRespository {
  Future<UserCredential> loginWithGoogle();
}
