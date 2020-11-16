import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/routing/application.dart';

class CheckOutScreen extends StatefulWidget {
  final Location args;

  const CheckOutScreen({Key key, this.args}) : super(key: key);

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState(args);
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final Location _args;

  _CheckOutScreenState(this._args);

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text("Safe Check Out"),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
        child: Center(
          child: ListView(
            children: [
              Container(
                height: 50,
              ),
              Card(
                color: Colors.red,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        size: 50,
                        color: Colors.white,
                      ),
                      title: Text('Out',
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                    Card(
                      color: Colors.grey[200],
                      child: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: screenWidth,
                            child: Column(
                              children: [
                                Container(
                                  height: 50,
                                ),
                                Text(_format(_args.checkOut),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 25)), //Dae
                                Container(
                                  height: 10,
                                ),
                                Text(_args.name.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                        fontSize: 25)), //Location
                                Container(
                                  height: 50,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
              ),
              SizedBox(
                height: 50,
                width: screenWidth * 0.9, // specific value
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Color(0xff1DE9B6),
                  textColor: Colors.white,
                  child: Text("BACK TO HOME", style: TextStyle(fontSize: 25)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _format(DateTime end) {
    String day = DateFormat('yyyy-MM-dd').format(end);
    String endTime = DateFormat('jm').format(end);
    return day + " to " + endTime;
  }
}
