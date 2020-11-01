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
    AssetImage assetImage2 = AssetImage('asset/images/slflag.png');
    Image image = Image(image: assetImage, width: screenWidth * 0.8);
    Image image2 = Image(
      image: assetImage2,
      width: screenWidth * 0.25,
    );

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

              //This container is only visible when patient is safe
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1, vertical: 20.0),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  leading: Icon(
                    Icons.beenhere_outlined,
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                  title: Text(
                    'You are okay',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Based on all your Trace Together and SafeEntry records from the last 14 days.See Details->'),
                  enabled: false,
                ),
              ),

              Row(
                children: <Widget>[
                  Container(
                    width: screenWidth * 0.09,
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth * 0.7,
                      child: Center(
                        child: Text(
                          "Let's stand together",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Container(
                        child: image2,
                      ),
                    ),
                  ),
                ],
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
                    horizontal: screenWidth * 0.2, vertical: 30.0),
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
