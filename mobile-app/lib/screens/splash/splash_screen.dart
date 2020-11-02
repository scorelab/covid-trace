import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //T
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/splash.jpg');
    AssetImage assetImage2 = AssetImage('asset/images/slflag.png');
    Image image1 = Image(
      image: assetImage,
      width: screenWidth,
      height: screenHeight * 0.3,
    );

    Image image2 = Image(
      image: assetImage2,
      width: screenWidth * 0.2,
      height: screenHeight * 0.07,
    );
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
          Application.router.navigateTo(context, Routes.main, clearStack: true);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.2,
          ),
          child: Center(
            child: Column(
              children: [
                image1,
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      image2,
                      Text(
                        "COVID-19 TRACKER",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 25),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Stay home! Stay safe!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff626262),
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Voluntary Drive to Expose Potential Covid - 19 \nSpread",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xff626262),
                      fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
