import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';

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
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('images/signup.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth*0.8,
      height: screenHeight*0.3,
    );
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
        body: Builder(
          builder: (context) => Form(
            key: _signupFormKey,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  Container(height: 50),
                  Center(
                    child: Text(
                      "To get started we need following",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20),
                    ),
                  ),
                  Center(
                    child: Container(
                      child: image,
                    ),
                  ),

                  //Phone Number
                  LabelTextFormField(
                    labelText: "Phone Number",
                    controller: _phoneNumberTEController,
                    keyboardType: TextInputType.number,
                  ),

                  //NIC
                  LabelTextFormField(
                    labelText: "NIC",
                    controller: _nicTEController,
                  ),

                  //Password
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: 8.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: _passwordTEController,
                      validator: _passwordValidator,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(top: 0),
                            // add padding to adjust icon
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.4),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),)
                      ),
                    ),
                  ),

                  //Login button
                  if (_signingin)
                    Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ))
                  else
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.18, vertical: 30.0),
                      child : ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_signupFormKey.currentState.validate()) {
                                _onSignUp();
                              }
                            });
                          },
                        ),
                      ),

                    ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1, vertical: 8.0),
                    child: GestureDetector(
                      onTap: _signin,
                      child: Center(
                        child: Text(
                          "Go back to Log In Screen",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 50),
                ],
              ),
            ),
          ),
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

      Provider.of<AuthBloc>(context, listen: false)
          .signUp(UserRegisterRequest(name, nic, phoneNumber, password));
    } else {
      setState(() {
        _signingin = false;
      });
    }
  }

  void _signin() {
    Application.router.pop(context);
  }
}