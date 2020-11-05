//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login_page.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  RootPage({
    this.auth,
  });
  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        //authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return Scaffold(
          appBar: AppBar(
            title: Text('Welcome'),
          ),
        );
    }
    return null;
  }
}
