import 'package:electronic_card/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({this.user, this.auth, this.onSignedOut});
  final User user;
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _logout() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home${user.email}'),
          actions: <Widget>[
            FlatButton(
              onPressed: _logout,
              child: Text(
                'Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
            )
          ],
        ),
        body: Container(
          child: Center(
            child: Text(
              'welcome',
              style: TextStyle(fontSize: 32.0),
            ),
          ),
        ));
  }
}
