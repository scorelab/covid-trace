import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/states/checkin_bloc/checkin_bloc.dart';
import 'package:intl/intl.dart';

var _state = true;

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
      body: Column(
        children: [
          Row(
            children: <Widget>[
              Expanded(
                child: ButtonTheme(
                  height: 30,
                  minWidth: screenWidth * 0.47,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      'ALL RECORDS',
                      textScaleFactor: 0.85,
                    ),
                    onPressed: () {
                      setState(() {
                        _state = true;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ButtonTheme(
                  height: 30,
                  minWidth: screenWidth * 0.47,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      'POSSIBLE EXPOSURES',
                      textScaleFactor: 0.85,
                    ),
                    onPressed: () {
                      setState(() {
                        _state = false;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          StreamBuilder(
            stream: BlocProvider.of<CheckInBloc>(context).checkedOutLocations,
            builder: _buildCheckedOut,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckedOut(context, AsyncSnapshot<List<Location>> snapshot) {
    if (!snapshot.hasData) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        Location location = snapshot.data[index];
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
            title: Text(location.name, //data.name[index]
                style: TextStyle(color: Colors.black, fontSize: 16)),
            subtitle: Text(_genTimePeriod(location.checkIn, location.checkOut),
                //data.time[index]
                style: TextStyle(color: Colors.black54)),
          ),
        );
      },
    );
  }

  String _genTimePeriod(DateTime start, DateTime end) {
    String day = DateFormat('yyyy-MM-dd').format(start);
    String startTime = DateFormat('jm').format(start);
    String endTime = DateFormat('jm').format(start);

    return day + " from " + startTime + " to " + endTime;
  }
}
