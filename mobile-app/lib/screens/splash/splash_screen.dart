import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      cubit: Provider.of<AuthBloc>(context),
      listener: (BuildContext context, AuthState state) async {
        //TODO:  2 sec delay. remove later
        await Future.delayed(Duration(seconds: 2));
        if (state is Unauthenticated) {
          Application.router
              .navigateTo(context, Routes.signin, clearStack: true);
        }
        if (state is Authenticated) {
          Application.router.navigateTo(context, Routes.home, clearStack: true);
        }
      },
      child: Scaffold(
        body: Center(
          child: Text("splash"),
        ),
      ),
    );
  }
}
