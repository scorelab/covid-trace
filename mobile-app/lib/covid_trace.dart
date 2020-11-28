import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/core/di/injection.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';
import 'package:slcovid_tracker/states/checkin_bloc/checkin_bloc.dart';
import 'package:slcovid_tracker/states/exposed_bloc/exposed_bloc.dart';
import 'package:slcovid_tracker/states/upload_bloc/upload_bloc.dart';

class CovidTrace extends StatelessWidget {
  CovidTrace() {
    Application.initiateRoutes();
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              BlocProvider<AuthBloc>(
                create: (BuildContext context) =>
                    getIt<AuthBloc>()..add(GetCurrentUserEvent()),
              ),
              BlocProvider<CheckInBloc>(
                create: (BuildContext context) => getIt<CheckInBloc>(),
              ),
              BlocProvider<ExposedBloc>(
                create: (BuildContext context) => getIt<ExposedBloc>(),
              ),
              BlocProvider<UploadBloc>(
                create: (BuildContext context) => getIt<UploadBloc>(),
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

        return Container();
      },
    );
  }
}
