import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> signUp(String email, String password);

  Future<String> currentUser();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password) as FirebaseUser;
    return user.uid;
  }

  @override
  Future<String> signUp(String email, String password) async {
    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password) as FirebaseUser;
    try {
      await user.sendEmailVerification();
    } catch (e) {
      print("An error occurred while trying to send email verification");
      print(e.message);
    }
    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = _firebaseAuth.currentUser as FirebaseUser;
    return user.uid;
  }
}
