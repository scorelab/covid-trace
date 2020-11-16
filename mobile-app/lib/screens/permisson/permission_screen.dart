import 'package:flutter/material.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';

class PermissionScreenArgs {
  final bool toVerify;

  PermissionScreenArgs({@required this.toVerify});
}

class PermissionScreen extends StatelessWidget {
  final PermissionScreenArgs args;

  const PermissionScreen({Key key, this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/permission.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth,
      height: screenHeight * 0.4,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: screenHeight * 0.1,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                  "To  help you note possible exposure to \n COVID -19  ,your app needs these\n permissions",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
              SizedBox(
                height: 5,
              ),
              image,
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth * 0.1, right: screenWidth * 0.3),
                child: Column(
                  children: [
                    _Permissiondetails(
                      caption: "SMS Permission",
                      icon: Icons.sms,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _Permissiondetails(
                      caption: "Camera Permission",
                      icon: Icons.camera_alt,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _Permissiondetails(
                      caption: "Notification Permission",
                      icon: Icons.notifications,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    _Permissiondetails(
                      caption: "Let app run in the background",
                      icon: Icons.play_circle_fill,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  "***All of your data will be stored in locally.We wont collect your \n information and we respect your Privacy***",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                  width: screenWidth * 0.9, // specific value
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                  onPressed: () => _gotoMain(context),
                  color: Color(0xff1DE9B6),
                  textColor: Colors.white,
                  child: Text(
                    "Allow",
                  
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _gotoMain(context) {
    if (args.toVerify) {
      Application.router
          .navigateTo(context, Routes.verification, clearStack: true);
    } else {
      Application.router.navigateTo(context, Routes.main, clearStack: true);
    }
  }
}

class _Permissiondetails extends StatelessWidget {
  final String caption;
  final IconData icon;
  const _Permissiondetails({this.caption, this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.black54,
          size: 28.0,
        ),
        SizedBox(
          width: 5,
        ),
        Text(caption,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 15))
      ],
    );
  }
}
