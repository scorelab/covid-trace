import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/home.png');
    Image image = Image(image: assetImage, width: screenWidth);

    return Scaffold(
      bottomNavigationBar: AppBottomNavbar(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              //logout function
            },
            color: Colors.grey[700],
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 0,
        ),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                  child: image,
                ),
              ),
              Center(
                child: Text(
                  "Verification",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 30),
                ),
              ),
              Container(height: 20),
              Center(
                child: Text(
                  "Enter the verification code we just sent you",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.18, vertical: 30.0),
                child: ButtonTheme(
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      'Verify',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      //verify function
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
