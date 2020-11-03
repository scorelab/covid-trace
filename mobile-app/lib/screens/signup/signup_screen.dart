import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';

var _n = 55.00;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  final _phoneNumberTEController = TextEditingController();
  final _nicTEController = TextEditingController();
  final _passwordTEController = TextEditingController();
  bool _signingin = false;

  @override
  void initState() {
    setState(() {
      _n = 55;
    });
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signup.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.4,
    );
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Unauthenticated) {
          setState(() {
            _signingin = false;
          });
        }
        if (state is AuthLoading) {
          setState(() {
            _signingin = true;
          });
        }
        if (state is AuthFailed) {
          print(state.error);
          setState(() {
            _signingin = false;
          });
        }
        if (state is Authenticated) {
          setState(() {
            _signingin = false;
          });
          Application.router.navigateTo(context, Routes.verification);
        }
      },
      cubit: Provider.of<AuthBloc>(context),
      child: Scaffold(
        body: Builder(
          builder: (context) => Form(
            key: _signupFormKey,
            child: Padding(
              padding: EdgeInsets.only( left: 10.0, right: 10.0),
              child: ListView(
                children: <Widget>[
                  Container(height: 25),
                  Center(
                    child: Text(
                      "To get started we need following",
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

                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: ButtonTheme(
                            height: _n,
                            minWidth: 20,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)),
                              ),
                              color: Colors.grey[200],
                              textColor: Colors.black54,
                              child: Text(
                                '+94',
                                textScaleFactor: 1.5,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: TextFormField(
                              controller: _phoneNumberTEController,
                              validator: (String value) {
                                if (value.isEmpty) {
                                  setState(() {
                                    _n = 80;
                                  });

                                  return "Phone number is required";
                                }
                                if (value.toString().length < 9) {
                                  setState(() {
                                    _n = 80;
                                  });
                                  return "9 digits required. Ex: 713456789";
                                }
                                if (value.toString().length > 9) {
                                  setState(() {
                                    _n = 80;
                                  });
                                  return "Phone number should be valid";
                                }
                                if (!(value is int)) {
                                  setState(() {
                                    _n = 80;
                                  });
                                  return "Phone number should only contains digits";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    // add padding to adjust icon
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 0.4),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Phone Number

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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          )),
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
                          horizontal: screenWidth * 0.18, vertical: 15.0),
                      child: ButtonTheme(
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            if (_signupFormKey.currentState.validate()) {
                              _onSignUp();
                            }
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
    if (_signupFormKey.currentState.validate()) {
      final nic = _nicTEController.text.toString();
      final phoneNumber = "+94" + _phoneNumberTEController.text.toString();
      final password = _passwordTEController.text.toString();

      Provider.of<AuthBloc>(context, listen: false).add(SignUpEvent(
          request: UserRegisterRequest(nic, phoneNumber, password)));
    }
  }

  void _signin() {
    Application.router.pop(context);
  }
}
