import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:slcovid_tracker/screens/home/home_screen.dart';
import 'package:slcovid_tracker/screens/signin/signin_screen.dart';
import 'package:slcovid_tracker/screens/signup/signup_screen.dart';
import 'package:slcovid_tracker/screens/splash/splash_screen.dart';

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var signinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SigninScreen();
});

var signupHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignupScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});
