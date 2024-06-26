import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Login_page.dart';
import 'auth.dart';

class SignUp extends StatefulWidget {
  SignUp({this.auth});
  final BaseAuth auth;
  @override
  _SignUpState createState() => _SignUpState();
}

final TextEditingController _controller3 = TextEditingController();
final FocusNode _focusNode3 = FocusNode(canRequestFocus: true);
final TextEditingController _controller4 = TextEditingController();
final FocusNode _focusNode4 = FocusNode(canRequestFocus: true);
final TextEditingController _controller5 = TextEditingController();
final FocusNode _focusNode5 = FocusNode(canRequestFocus: true);
final TextEditingController _controller1 = TextEditingController();
final FocusNode _focusNode1 = FocusNode(canRequestFocus: true);
final TextEditingController _controller2 = TextEditingController();
final FocusNode _focusNode2 = FocusNode(canRequestFocus: true);

enum FormType {
  register,
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  String code = '*******';
  String _email;
  String _password;
  FormType _formType = FormType.register;

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
        if (_formType == FormType.register) {
          String userId = await widget.auth.signUp(_email, _password);
          print('Registered user: $userId');
          await auth.checkActionCode(code);
          await auth.applyActionCode(code);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  Future navigateLoginPage(context) async {
    Navigator.pop(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future navigateToLoginPage(context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value) || !(value.length <= 6))
        return '6 at least 1 upper case, lowercase, numbers and characters';
      else
        return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter email';
    } else {
      if (!regex.hasMatch(value))
        return 'enter valid email';
      else
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 45,
              ),
              SizedBox(
                  child: Text(
                'Registration Page',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue.shade400,
                    decorationColor: Colors.lightBlue,
                    fontFamily: 'NotoSans'),
              )),
              SizedBox(
                height: 25,
                width: 400,
                child: Text(
                  'Create a free account to start sharing eCard',
                  style: TextStyle(fontSize: 20, fontFamily: 'Caveat'),
                ),
              ),
              SizedBox(
                width: 200,
                height: 8,
                child: Divider(),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'input designation';
                          }
                          return null;
                        },
                        onSaved: (value) => value,
                        decoration: InputDecoration(
                          hintText: 'Mr, Mrs,Professor etc.',
                          prefixIcon: Icon(Icons.person_pin),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        focusNode: _focusNode1,
                        controller: _controller1,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) => value,
                        decoration: InputDecoration(
                          hintText: 'Enter full name',
                          prefixIcon: Icon(Icons.person),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        focusNode: _focusNode2,
                        controller: _controller2,
                        validator: validateEmail,
                        onSaved: (value) => value,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        focusNode: _focusNode3,
                        controller: _controller3,
                        validator: validatePassword,
                        onSaved: (value) => value,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (!(value.length <= 14) || value.isEmpty) {
                            return 'enter valid phone number';
                          }
                          return null;
                        },
                        onSaved: (value) => value,
                        focusNode: _focusNode4,
                        controller: _controller4,
                        decoration: InputDecoration(
                          hintText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'enter your address';
                          }
                          return null;
                        },
                        onSaved: (value) => value,
                        focusNode: _focusNode5,
                        controller: _controller5,
                        decoration: InputDecoration(
                          hintText: 'Address',
                          prefixIcon: Icon(Icons.add_location),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                child: RaisedButton(
                  color: Colors.blue,
                  onPressed: () {
                    if (validateAndSubmit != null) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
              Container(
                child: OutlineButton(
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 30),
                  color: Colors.white,
                  borderSide: BorderSide(color: Colors.white),
                  onPressed: () {
                    navigateToLoginPage(context);
                  },
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
