import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SafeEntryBeforeCheckInScreen extends StatefulWidget {
  @override
  _SafeEntryBeforeCheckInScreenState createState() =>
      _SafeEntryBeforeCheckInScreenState();
}

class _SafeEntryBeforeCheckInScreenState
    extends State<SafeEntryBeforeCheckInScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text("Safe Check In"),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
        child: Center(
          child: ListView(
            children: [
              Text(
                'Check in to :',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 17),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: ListTile(
                  tileColor: Colors.grey[200],
                  title: Text(
                    'University of Colombo', //location
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  subtitle: Text(
                    'College House, 94 Kumaratunga Munidasa Mawatha, Colombo 00700',
                    //address
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),
                  enabled: false,
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black54, fontSize: 17),
                  children: <TextSpan>[
                    TextSpan(text: 'By Check-In, I declare that:\n\n'),
                    TextSpan(
                        text:
                            '- I have no close contact a confirmed Covid-19 case in last 14 days\n'),
                    TextSpan(text: "- I am not under a Quarantine\n"),
                    TextSpan(text: '- My body temperature is 38C\n'),
                    TextSpan(text: '- I have no Covid-19 symptoms\n'),
                    TextSpan(text: '      - Fever\n'),
                    TextSpan(text: "      - Running Nose\n"),
                    TextSpan(text: '      - Sore Throat\n'),
                    TextSpan(text: '      - Dry cough\n'),
                    TextSpan(text: '      - Difficulty in Breathing\n'),
                    TextSpan(text: '      - Tiredness\n'),
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
                      'CHECK IN',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/safeentrycheckin');
                      //CALL CHECK IN FUNCTION
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
