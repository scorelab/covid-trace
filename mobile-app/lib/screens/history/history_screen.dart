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
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  minWidth: screenWidth * 0.47,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: _isAllRecords
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      'ALL RECORDS',
                    ),
                    onPressed: () {
                      setState(() {
                        _isAllRecords = true;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  minWidth: screenWidth * 0.47,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: !_isAllRecords
                        ? Theme.of(context).primaryColor
                        : Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      'POSSIBLE EXPOSURES',
                    ),
                    onPressed: () {
                      setState(() {
                        _isAllRecords = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          if (_isAllRecords) AllRecords() else PossibleExpo()
        ],
      ),
    );
  }
}
