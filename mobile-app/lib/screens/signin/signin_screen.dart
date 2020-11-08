import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';

var _countryCode = "+94";

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  var _signinFormKey = GlobalKey<FormState>();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;

  void _onCountryChange(CountryCode countryCode) {
    setState(() {
      _countryCode = countryCode.toString();
    });
  }

  @override
  void initState() {
    setState(() {
      _countryCode = "+94";
    });
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/signin.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth,
      height: screenHeight * 0.32,
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
          showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Error'),
        content: Text(
                  "Invalid login credentials. Please try again"),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
            setState(() {
              _isLoading = false;
            });
          }
          if (state is Authenticated) {
            setState(() {
              _isLoading = false;
            });
            Application.router
                .navigateTo(context, Routes.main, clearStack: true);
          }
        },
        cubit: Provider.of<AuthBloc>(context),
        child: Scaffold(
          body: Builder(
            builder: (context) => Form(
              key: _signinFormKey,
              child: Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.02, left: 10.0, right: 10.0),
                child: ListView(
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Welcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                    ),
                    Center(
                      child: Container(
                        child: image,
                      ),
                    ),

                    //Phone Number
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05, vertical: 8.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 14,
                            child: ButtonTheme(
                              height: 55,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                color: Colors.grey[100],
                                textColor: Colors.white,
                                child: CountryCodePicker(
                                  onChanged: _onCountryChange,
                                  initialSelection: 'LK',
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                ),
                                onPressed: () {},
                              ),
                            ),

                            // ButtonTheme(
                            //   height: _n,
                            //   minWidth: 20,
                            //   child: RaisedButton(
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.only(
                            //           topLeft: Radius.circular(10),
                            //           bottomLeft: Radius.circular(10)),
                            //     ),
                            //     color: Colors.grey[200],
                            //     textColor: Colors.black54,
                            //     child: Text(
                            //       '+94',
                            //       textScaleFactor: 1.5,
                            //     ),
                            //     onPressed: () {},
                            //   ),
                            // ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 21,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: TextFormField(
                                controller: _numberController,
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Phone number is required";
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
      final phoneNumber = _countryCode + _numberController.text.toString();
      final password = _passwordController.text.toString();

      Provider.of<AuthBloc>(context, listen: false)
          .add(SignInEvent(request: UserSignInRequest(phoneNumber, password)));
    }
  }

  void _signup() {
    Application.router.navigateTo(context, Routes.signup);
  }

  
}
