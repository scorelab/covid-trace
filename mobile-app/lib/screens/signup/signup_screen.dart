import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/data/dto/user_dto.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/screens/permisson/permission_screen.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';
import 'package:country_code_picker/country_code_picker.dart';

var _countryCode = "+94";

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
          Application.router.navigateTo(context, Routes.permission,
              routeSettings: RouteSettings(
                arguments: PermissionScreenArgs(toVerify: true),
              ),
              clearStack: true);
        }
      },
      cubit: Provider.of<AuthBloc>(context),
      child: Scaffold(
        body: Builder(
          builder: (context) => Form(
            key: _signupFormKey,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
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

                  //Phone Number
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05, vertical: 8.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        controller: _phoneNumberTEController,
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
                              padding: EdgeInsets.only(left: 2.0, right: 10.0),
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
                  ),

                  //NIC
                  LabelTextFormField(
                    labelText: "NIC",
                    controller: _nicTEController,
                  ),
                  LabelTextFormField(
                    labelText: "Password",
                    controller: _passwordTEController,
                    isObscure: true,
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
                        child: SizedBox(
                          height: 50,
                          width: screenWidth * 0.9, // specific value
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            onPressed: () {
                              if (_signupFormKey.currentState.validate()) {
                                _onSignUp();
                              }
                            },
                            color: Color(0xff1DE9B6),
                            textColor: Colors.white,
                            child:
                                Text("Sign Up", style: TextStyle(fontSize: 25)),
                          ),
                        )),
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
    print(_countryCode + _phoneNumberTEController.text.toString());
    if (_signupFormKey.currentState.validate()) {
      final nic = _nicTEController.text.toString();
      final phoneNumber =
          _countryCode + _phoneNumberTEController.text.toString();
      final password = _passwordTEController.text.toString();

      Provider.of<AuthBloc>(context, listen: false).add(SignUpEvent(
          request: UserRegisterRequest(nic, phoneNumber, password)));
    }
  }

  void _signin() {
    Application.router.pop(context);
  }
}
