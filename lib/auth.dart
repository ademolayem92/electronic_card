import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  //Stream<dynamic> get onAuthStateChanged;
  Future<String> signInWithEmailAndPassword(email, password);
  Future<String> signUp(email, password);
  Future<String> currentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user1 = FirebaseAuth.instance.currentUser;
  String code = '*******';

  @override
  Future<String> signInWithEmailAndPassword(email, password) async {
    User userCredentials = await _auth.signInWithEmailAndPassword(
        email: email, password: password) as User;

    return userCredentials?.uid;
  }

  @override
  Future<String> signUp(email, password) async {
    User userCredentials = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    )) as User;
    if (!user1.emailVerified) {
      await user1.sendEmailVerification();
      try {
        await _auth.checkActionCode(code);
        await _auth.applyActionCode(code);

        // If successful, reload the user:
        _auth.currentUser.reload();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-action-code') {
          print('The code is invalid.');
        }
      }
    }
    return userCredentials?.uid;
  }

  @override
  Future<String> currentUser() async {
    // ignore: await_only_futures
    User userCredentials = await _auth.currentUser;
    if (_auth.currentUser != null) {
      print(_auth.currentUser.uid);
    }
    return userCredentials?.uid;
  }

  @override
  Future<void> signOut() async {
    return _auth.signOut();
  }
}
