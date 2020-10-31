import 'package:flutter/material.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Login screen"),
          Spacer(),
          RaisedButton(
            onPressed: _signup,
            child: Text("sign up"),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  void _signup() {
    Application.router.navigateTo(context, Routes.signup);
  }
}