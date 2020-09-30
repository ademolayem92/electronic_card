import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SignUp.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  _LoginPageState createState() => _LoginPageState();
}

final TextEditingController _controller = TextEditingController();
final FocusNode _focusNode = FocusNode(canRequestFocus: true);
final TextEditingController _controllerTwo = TextEditingController();
final FocusNode _focusNodeTwo = FocusNode(canRequestFocus: true);

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  Future navigateToSignUp(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  ///Future navigateToForgottenPassword(context) async{
  /// Navigator.push(context, MaterialPageRoute(builder: (context)=>
  /// ForgottenPassword()));
  // }
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      //form.save() saves the email and password given
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);

          print('Signed in: $userId');
        }
        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegistration() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Center(
                child: Text(
              'eCard',
              style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.w800,
                  color: Colors.blue.shade400,
                  decorationColor: Colors.lightBlue,
                  fontFamily: 'Pacifico'),
            )),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: SizedBox(
                  height: 5.0,
                  width: 150.0,
                  child: Divider(
                    color: Colors.blue.shade100,
                  ),
                ),
              ),
            ),
            Stack(children: <Widget>[
              Container(
                child: Text(
                  'Hello,',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 30.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 25,
              child: Text(
                'Securely log in to create your eCard',
                style: TextStyle(fontSize: 20, fontFamily: 'Caveat'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 25.0),
              child: Form(
                key: formKey,
                child: Column(children: <Widget>[
                  Card(
                    child: TextFormField(
                        maxLines: 1,
                        minLines: null,
                        focusNode: _focusNodeTwo,
                        cursorColor: Colors.white30,
                        controller: _controllerTwo,
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                            //to put boarder in the whole textField.
                            //prefixIcon: used to put icon like email icon before the text.
                            hintText: 'Email',
                            prefixIcon: Icon(Icons.email)),
                        autovalidate: false,
                        onSaved: (value) => _email = value,
                        validator: (value) =>
                            value.isEmpty ? 'Email can\'t be empty' : null,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.teal.shade900,
                            fontFamily: 'Caveat')),
                  ),
                  Card(
                    child: TextFormField(
                      focusNode:
                          _focusNode, // I import the function to create a
                      // focusNode
                      //and pass it here it here
                      cursorColor: Colors.white30,
                      controller:
                          _controller, //obscureText:(bool) is used to hide
                      // text
                      enableInteractiveSelection: true,
                      toolbarOptions: const ToolbarOptions(
                          copy: true, cut: true, paste: true, selectAll: true),
                      autocorrect: true,
                      expands: false,
                      readOnly: false,
                      autovalidate: false,
                      onSaved: (value) => _password = value,

                      style: TextStyle(
                        fontFamily: 'Caveat',
                        color: Colors.teal.shade900,
                        fontSize: 15.0,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blueAccent)),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                      textAlign: TextAlign.start,
                      validator: (value) {
                        if (!(value.length == 14) || value.isEmpty) {
                          return 'wrong password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                  ),
                ]),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(color: Colors.blue),
                    ),
                    color: Colors.blue,
                    onPressed: validateAndSubmit,
                    child: Text(
                      'Sign In',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  //flatButton can also be used to remove the background
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    color: Colors.white,
                    onPressed: () {
                      navigateToSignUp(context);
                    },
                    child: Text(
                      'Don\'t have an account? Register',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                ),
                Container(
                  child: OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    color: Colors.blue,
                    borderSide: BorderSide(color: Colors.white),
                    onPressed: () {
                      //navigateToForgottenPassword(context);
                    },
                    child: Text(
                      'forgotten password?',
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
