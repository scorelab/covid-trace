import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';
import 'package:flutter/gestures.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    AssetImage assetImage = AssetImage('asset/images/home.png');
    AssetImage assetImage2 = AssetImage('asset/images/slflag.png');
    Image image = Image(image: assetImage, width: screenWidth * 0.4);
    Image image2 = Image(
      image: assetImage2,
      width: screenWidth * 0.17,
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
              //Call a fuction to log out
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
                  subtitle: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                'Based on all your Trace Together and SafeEntry records from the last 14 days. '),
                        TextSpan(
                            text: 'See Details->',
                            style: TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Call a function to see details
                              }),
                      ],
                    ),
                  ),
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

              Container(height: 5),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.07, vertical: 2.0),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Last QR check In',
                          style: TextStyle(color: Colors.grey, fontSize: 20),
                        ),
                        subtitle: Text(
                          'University of Colombo',
                          //Location name should be replaced
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ButtonTheme(
                            height: 40,
                            minWidth: screenWidth * 0.38,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              color: Colors.grey,
                              textColor: Colors.white,
                              child: Text(
                                'VIEW PASS',
                                textScaleFactor: 1.3,
                              ),
                              onPressed: () {
                                //Call a function to view pass
                              },
                            ),
                          ),
                          ButtonTheme(
                            height: 40,
                            minWidth: screenWidth * 0.38,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text(
                                'CHECK OUT',
                                textScaleFactor: 1.3,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/checkout');
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.07),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 15,
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(
                            Icons.login_rounded,
                            color: Colors.red,
                            size: 40.0,
                          ),
                          Text(
                            "Safe Check In",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          ButtonTheme(
                            height: 40,
                            minWidth: screenWidth * 0.38,
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text(
                                'NEW CHECK IN',
                                textScaleFactor: 1.3,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/safeentrybeforecheckin');
                              },
                            ),
                          ),
                        ],
                      ),

                    ],
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
