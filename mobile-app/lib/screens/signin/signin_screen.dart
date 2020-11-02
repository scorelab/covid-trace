import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.8,
      height: screenHeight * 0.4,
    );
    return BlocListener<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is Unauthenticated) {
            setState(() {
              _isLoading = false;
            });
          }
          if (state is AuthLoading) {
            setState(() {
              _isLoading = true;
            });
          }
          if (state is AuthFailed) {
            print(state.error);
            setState(() {
              _isLoading = false;
            });
          }
          if (state is Authenticated) {
            setState(() {
              _isLoading = false;
            });
            Application.router.navigateTo(context, Routes.main, clearStack: true);
          }
        },
        cubit: Provider.of<AuthBloc>(context),
        child: Scaffold(
          body: Builder(
            builder: (context) => Form(
              key: _signinFormKey,
              child: Padding(
                padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                child: ListView(
                  children: <Widget>[
                    Container(height: 50),
                    Center(
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 20),
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
                      controller: _numberController,
                      keyboardType: TextInputType.number,
                    ),

                    //Password
                    LabelTextFormField(
                      labelText: "Password",
                      controller: _passwordController,
                      isObscure: true,
                    ),

                    //Login button
                    if (_isLoading)
                      Center(
                          child: CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      ))
                    else
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.18, vertical: 30.0),
                        child: ButtonTheme(
                          height: 50,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: Text(
                              'Sign In',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              if (_signinFormKey.currentState.validate()) {
                                _signIn();
                              }
                            },
                          ),
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: 8.0),
                      child: Center(
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1, vertical: 8.0),
                      child: GestureDetector(
                        onTap: _signup,
                        child: Center(
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _signIn() {
    if (_signinFormKey.currentState.validate()) {
      final phoneNumber = _numberController.text.toString();
      final password = _passwordController.text.toString();

      Provider.of<AuthBloc>(context, listen: false)
          .add(SignInEvent(request: UserSignInRequest(phoneNumber, password)));
    }
  }

  void _signup() {
    Application.router.navigateTo(context, Routes.signup);
  }
}
