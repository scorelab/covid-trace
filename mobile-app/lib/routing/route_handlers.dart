import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:slcovid_tracker/screens/splash/splash_screen.dart';

var mainHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Container();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Container();
});
