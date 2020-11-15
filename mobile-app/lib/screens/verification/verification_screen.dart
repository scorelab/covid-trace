import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/verify_bloc/verify_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  User _user;
  Timer _timer;
  int _start = 100;
  bool _loading = false;
  String _code = "";

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            Application.router.navigateTo(context, Routes.signup);
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startTimer();
    BlocProvider.of<VerifyBloc>(context).add(SendVerificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/verification.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth * 0.8,
      height: screenHeight * 0.3,
    );

    return BlocListener<VerifyBloc, VerifyState>(
        listener: (BuildContext context, VerifyState state) {
          if (state is VerifyLoading) {
            setState(() {
              _loading = true;
            });
          }
          if (state is SentVerification) {
            setState(() {
              _loading = false;
              _user = state.user;
              _code = state.code;
            });
          }
          if (state is CodeReceived) {
            _loading = false;
            _timer.cancel();
            _verifyPhone();
          }
          if (state is VerifyFailed) {
            setState(() {
              _loading = false;
            });
            print(state.error);
          }
          if (state is VerifySuccess) {
            Application.router
                .navigateTo(context, Routes.main, clearStack: true);
          }
        },
        cubit: Provider.of<VerifyBloc>(context),
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: screenHeight * 0.1,
            ),
            child: Center(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      child: image,
                    ),
                  ),
                  Center(
                    child: Text(
                      "Verification",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 30),
                    ),
                  ),
                  Container(height: 20),
                  Center(
                    child: Text(
                      "Enter the verification code we just sent you",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Center(
                    child: Text(
                      "on your mobile number " +
                          (_user != null ? _user.phoneNumber : ''),
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Container(height: 20),
                  Center(
                    child: Text(
                      "Remaining time : $_start secs",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),

                  //Box Pin Code field as requested
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.03,
                        left: screenWidth * 0.07,
                        right: screenWidth * 0.07),
                    child: Center(
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        validator: (v) {
                          if (v.length < 6) {
                            return "6 digits required";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveColor: Colors.grey,
                          inactiveFillColor: Colors.transparent,
                          activeFillColor: Colors.transparent,
                          activeColor: Colors.black54,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(2),
                          fieldHeight: 50,
                          fieldWidth: 50,
                        ),
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        keyboardType: TextInputType.number,
                        onCompleted: (String value) {
                          _matchManual(value);
                        },
                        onChanged: (value) {},
                      ),
                    ),
                  ),

                  // Center(
                  //   child: VerificationCode(
                  //     textStyle: TextStyle(fontSize: 20.0, color: Colors.grey),
                  //     underlineColor: Theme.of(context).primaryColor,
                  //     keyboardType: TextInputType.number,
                  //     length: 6,
                  //     onCompleted: (String value) {
                  //       _matchManual(value);
                  //     },
                  //     onEditing: (bool value) {
                  //       setState(() {
                  //         //edit
                  //       });
                  //     },
                  //   ),
                  // ),

                  if (_loading)
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
                            'Verify',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            //verify function
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ));
  }

  void _matchManual(String code) {
    if (_code == code) {
      _verifyPhone();
    }
  }

  void _verifyPhone() {
    Provider.of<VerifyBloc>(context, listen: false)
        .add(VerifyPhoneEvent(userId: _user.id));
  }
}
