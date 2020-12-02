import 'package:flutter/material.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/covid_trace.dart';
import 'package:slcovid_tracker/workers/check_exposed_worker.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  Workmanager.initialize(
    checkExposedCallback,
    isInDebugMode: false,
  );
  Workmanager.registerPeriodicTask(
    "1",
    "checkExposed",
    existingWorkPolicy: ExistingWorkPolicy.replace,
    initialDelay: Duration(seconds: 30),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
    frequency: Duration(hours: 6),
  );

  runApp(CovidTrace());
}
