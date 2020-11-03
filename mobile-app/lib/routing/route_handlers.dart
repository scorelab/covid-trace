import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/screens/checkin/checkin_screen.dart';
import 'package:slcovid_tracker/screens/checkout/checkout_screen.dart';
import 'package:slcovid_tracker/screens/main/main_screen.dart';
import 'package:slcovid_tracker/screens/permisson/permission_screen.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';
import 'package:slcovid_tracker/screens/safeentrycheckin/safeentrycheckin_screen.dart';
import 'package:slcovid_tracker/screens/signin/signin_screen.dart';
import 'package:slcovid_tracker/screens/signup/signup_screen.dart';
import 'package:slcovid_tracker/screens/splash/splash_screen.dart';
import 'package:slcovid_tracker/screens/verification/verification_screen.dart';
import 'package:slcovid_tracker/states/verify_bloc/verify_bloc.dart';

var splashHandler = Handler(
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

var verificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return BlocProvider<VerifyBloc>(
    create: (BuildContext context) => getIt<VerifyBloc>(),
    child: VerificationScreen(),
  );
});

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MainScreen();
});

var permissionHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PermissionScreen();
});

var checkinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CheckInScreen();
});

var safeentrybeforecheckinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  final args = context.arguments as SafeEntryBeforeCheckInScreenArgs;

  return SafeEntryBeforeCheckInScreen(args: args);
});

var safeentrycheckinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  final args = context.arguments as Location;

  return SafeEntryCheckInScreen(args: args);
});

var checkoutHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CheckOutScreen();
});
