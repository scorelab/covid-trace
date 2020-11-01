import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:slcovid_tracker/screens/history/history_screen.dart';
import 'package:slcovid_tracker/screens/home/home_screen.dart';
import 'package:slcovid_tracker/screens/permisson/permission_screen.dart';
import 'package:slcovid_tracker/screens/profile/profile_screen.dart';
import 'package:slcovid_tracker/screens/signin/signin_screen.dart';
import 'package:slcovid_tracker/screens/signup/signup_screen.dart';
import 'package:slcovid_tracker/screens/splash/splash_screen.dart';
import 'package:slcovid_tracker/screens/upload/Upload_screen.dart';
import 'package:slcovid_tracker/screens/verification/verification_screen.dart';

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var signinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var signupHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignupScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeScreen();
});

var verificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VerificationScreen();
});

var permissionHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PermissionScreen();
});

var historyHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HistoryScreen();
});
var uploadHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UploadScreen();
});
var profileHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ProfileScreen();
});
