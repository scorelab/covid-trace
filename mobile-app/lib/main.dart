import 'package:flutter/material.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/covid_trace.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(CovidTrace());
}
