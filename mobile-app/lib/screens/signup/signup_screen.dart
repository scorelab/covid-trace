import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _nameTEController = TextEditingController();
  final _phoneNumberTEController = TextEditingController();
  final _nicTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  bool _signingin = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Unauthenticated) {
          setState(() {
            _signingin = false;
          });
        }
        if (state is Authenticated) {
          setState(() {
            _signingin = false;
          });
          Application.router.navigateTo(context, "/home", clearStack: true);
        }
      },
      cubit: Provider.of<AuthBloc>(context),
      child: Scaffold(
        body: Column(
          children: [
            Form(
              key: _signupFormKey,
              child: Column(
                children: [
                  Spacer(),
                  Visibility(
                    child: CircularProgressIndicator(
                      value: null,
                    ),
                    visible: _signingin,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                  ),
                  TextFormField(
                    controller: _nameTEController,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: _nameValidator,
                  ),
                  TextFormField(
                    controller: _phoneNumberTEController,
                    decoration: InputDecoration(labelText: "Phone number"),
                    validator: _phoneNumberValidator,
                  ),
                  TextFormField(
                    controller: _nicTEController,
                    decoration: InputDecoration(labelText: "NIC"),
                    validator: _nicValidator,
                  ),
                  TextFormField(
                    controller: _passwordTEController,
                    decoration: InputDecoration(labelText: "Password"),
                    validator: _passwordValidator,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: _onSignUp,
              child: Text("sign up"),
            ),
            Spacer(),
            RaisedButton(
              onPressed: _signin,
              child: Text("sign in"),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String _nameValidator(String name) {
    if (name.isEmpty) {
      return 'Please enter your name';
    }

    return null;
  }

  String _phoneNumberValidator(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Please enter the phone number';
    }

    // TODO: phone number regex match
    // if (phoneNumber.isEmpty) {
    //   return 'Please enter a valid phone number';
    // }

    return null;
  }

  String _nicValidator(String nic) {
    if (nic.isEmpty) {
      return 'Please enter the nic';
    }

    // TODO: nic regex match
    // if (phoneNumber.isEmpty) {
    //   return 'Please enter a valid phone number';
    // }

    return null;
  }

  String _passwordValidator(String password) {
    if (password.isEmpty) {
      return 'Please enter the passowrd';
    }

    if (password.length < 6) {
      return "Password must be at least 6 characters";
    }

    return null;
  }

  void _onSignUp() {
    setState(() {
      _signingin = true;
    });
    if (_signupFormKey.currentState.validate()) {
      final name = _nameTEController.text.toString();
      final nic = _nicTEController.text.toString();
      final phoneNumber = _phoneNumberTEController.text.toString();
      final password = _passwordTEController.text.toString();

      Provider.of<AuthBloc>(context)
          .signUp(UserRegisterRequest(name, nic, phoneNumber, password));
    }
  }

  void _signin() {
    Application.router.pop(context);
  }
}
