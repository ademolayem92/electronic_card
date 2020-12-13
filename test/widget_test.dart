// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:electronic_card/Login_page.dart';
import 'package:electronic_card/auth.dart';
import 'package:electronic_card/auth_provider.dart';
//import 'package:electronic_card/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuth implements BaseAuth {
  bool didAttemptSignIn;
  @override
  Future<String> currentUser() {
    // TODO: implement currentUser
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithEmailAndPassword(email, password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(email, password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}

void main() {
  Widget makeTestableWidget({Widget child, BaseAuth auth}) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.'
    MockAuth auth = MockAuth();

    LoginPage page = LoginPage(onSignedIn: () {});

    await tester.pumpWidget(makeTestableWidget(child: page, auth: auth));

    //expect signInWithEmailAndPassword
  });
}
