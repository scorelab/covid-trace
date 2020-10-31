import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/routing/application.dart';

class CovidTrace extends StatelessWidget {
  CovidTrace() {
    // Application.initiateRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        title: "Covid Trace",
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
