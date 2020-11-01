import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';

class CovidTrace extends StatelessWidget {
  CovidTrace() {
    Application.initiateRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) =>
              getIt<AuthBloc>()..add(GetCurrentUserEvent()),
        ),
      ],
      child: MaterialApp(
        title: "Covid Trace",
        onGenerateRoute: Application.router.generator,
        theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.tealAccent[400]),
          brightness: Brightness.light,
          primaryColor: Color(0xff1DE9B6),
          accentColor: Colors.white,
        ),
      ),
    );
  }
}
