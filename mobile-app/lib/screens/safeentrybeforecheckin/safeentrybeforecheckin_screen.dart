import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';
import 'package:flutter/gestures.dart';

class SafeEntryBeforeCheckInScreen extends StatefulWidget {
  @override
  _SafeEntryBeforeCheckInScreenState createState() => _SafeEntryBeforeCheckInScreenState();
}

class _SafeEntryBeforeCheckInScreenState extends State<SafeEntryBeforeCheckInScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text("Safe Check In"),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: screenWidth*0.06,
          right: screenWidth*0.06
        ),
        child: Center(
          child: ListView(
            children: [
              Text(
                'Check in to :',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: 20.0),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  title: Text(
                    'University of Colombo', //location
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    'College House, 94 Kumaratunga Munidasa Mawatha, Colombo 00700', //address
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  enabled: false,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black54),
                  children: <TextSpan>[
                    TextSpan(text: 'By checking in, you declare that:\n\n'),
                    TextSpan(text: '- You have no close contact with a confirmed COVID-19 case in the past 14 days\n'),
                    TextSpan(text: "- You're not currently under a Quarantine Order or Stay-Home Notice\n"),
                    TextSpan(text: '- You have no fever or flu-like symptoms\n'),
                    TextSpan(text: '- You agree to the '),
                    TextSpan(
                        text: 'terms ',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Call a function to see terms
                          }),
                    TextSpan(text: 'and consent to the collection/use of your information for COVID-19 contact tracing\n\n'),
                    TextSpan(text: "Not applicable if you're seeking treatment at a medical facility\n"),
                    TextSpan(text: 'Not applicable to COVID-19 frontline workers\n'),
                  ],
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
                      'Check In',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/safeentrycheckin');
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
