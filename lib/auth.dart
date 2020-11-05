import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  signInWithEmailAndPassword(String email, String password);
  signUp(String email, String password);
  currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;

  signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    return userCredential;
  }

  signUp(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
    return userCredential;
  }

  currentUser() async {
    User userCredential = _auth.currentUser;
    if (_auth.currentUser != null) {
      print(_auth.currentUser.uid);
    }
    return userCredential;
  }

  Future<void> signOut() async {
    return _auth.signOut();
  }
}
