//import 'package:electronic_card/auth.dart';
import 'package:electronic_card/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  void _logout(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
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
          title: Center(child: Text('Welcome')),
          actions: <Widget>[
            FlatButton(
              onPressed: () => _logout(context),
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
