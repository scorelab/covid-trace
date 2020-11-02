import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/screens/checkout/checkout_screen.dart';
import 'package:slcovid_tracker/screens/history/history_screen.dart';
import 'package:slcovid_tracker/screens/home/home_screen.dart';
import 'package:slcovid_tracker/screens/permisson/permission_screen.dart';
import 'package:slcovid_tracker/screens/profile/profile_screen.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';
import 'package:slcovid_tracker/screens/safeentrycheckin/safeentrycheckin_screen.dart';
import 'package:slcovid_tracker/screens/signin/signin_screen.dart';
import 'package:slcovid_tracker/screens/signup/signup_screen.dart';
import 'package:slcovid_tracker/screens/splash/splash_screen.dart';
import 'package:slcovid_tracker/screens/upload/Upload_screen.dart';
import 'package:slcovid_tracker/screens/verification/verification_screen.dart';
import 'package:slcovid_tracker/states/verify_bloc/verify_bloc.dart';

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

var verificationHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return BlocProvider<VerifyBloc>(
        create: (BuildContext context) => getIt<VerifyBloc>(),
        child: VerificationScreen(),
      );
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

var safeentrybeforecheckinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SafeEntryBeforeCheckInScreen();
});

var safeentrycheckinHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return SafeEntryCheckInScreen();
});

var checkoutHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return CheckOutScreen();
});
