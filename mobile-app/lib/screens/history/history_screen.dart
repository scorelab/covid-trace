import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/screens/history/pages/all_records.dart';
import 'package:slcovid_tracker/screens/history/pages/possible_expo.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _isAllRecords = true;

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("History"),
        ),
        backgroundColor: Colors.grey[300],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: screenWidth * 0.44, // specific value
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _isAllRecords = true;
                      });
                    },
                    color: _isAllRecords ? Color(0xff1DE9B6) : Colors.grey,
                    textColor: Colors.white,
                    child: Text("ALL RECORDS"),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: screenWidth * 0.52, // specific value
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    onPressed: () {
                      setState(() {
                        _isAllRecords = false;
                      });
                    },
                    color: !_isAllRecords ? Color(0xff1DE9B6) : Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      "POSSIBLE EXPOSURES",
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          _isAllRecords ? AllRecords() : PossibleExpo(),
        ],
      ),
    );
  }
}
