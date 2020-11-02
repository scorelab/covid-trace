import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
      bottomNavigationBar: AppBottomNavbar(),
      body: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ButtonTheme(
                height: 30,
                minWidth: screenWidth * 0.47,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                  child: Text(
                    'ALL RECORDS',
                    textScaleFactor: 1,
                  ),
                  onPressed: () {
                    //Call a function to view pass
                  },
                ),
              ),
              ButtonTheme(
                height: 30,
                minWidth: screenWidth * 0.47,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text(
                    'POSSIBLE EXPOSURES',
                    textScaleFactor: 1,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/checkout');
                  },
                ),
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  elevation: 2.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.location_on_rounded,
                        color: Colors.grey,
                      ),
                    ),
                    title:
                        Text(
                            "University of Colombo", //data.name[index]
                            style: TextStyle(color: Colors.black, fontSize: 16)
                        ),
                    subtitle:
                        Text(
                            "2020-08-02\n" //data.date[index]
                                "From "
                                "9.30 AM " //data.time[index]
                                "to "
                                "10.00 AM", //data.time[index]
                            style: TextStyle(color: Colors.black54)
                        ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
