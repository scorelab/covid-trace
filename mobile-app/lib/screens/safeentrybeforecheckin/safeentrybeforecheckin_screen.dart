import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/states/checkin_bloc/checkin_bloc.dart';

class SafeEntryBeforeCheckInScreenArgs {
  final String url;

  SafeEntryBeforeCheckInScreenArgs(this.url);
}

class SafeEntryLocation {
  final String type;
  final String id;

  SafeEntryLocation(this.type, this.id);
}

class SafeEntryBeforeCheckInScreen extends StatefulWidget {
  final SafeEntryBeforeCheckInScreenArgs args;

  const SafeEntryBeforeCheckInScreen({Key key, @required this.args})
      : super(key: key);

  @override
  _SafeEntryBeforeCheckInScreenState createState() =>
      _SafeEntryBeforeCheckInScreenState(args);
}

class _SafeEntryBeforeCheckInScreenState
    extends State<SafeEntryBeforeCheckInScreen> {
  final SafeEntryBeforeCheckInScreenArgs _args;
  bool _fetching = false;
  bool _isInvalidUrl = false;
  Location _location;

  _SafeEntryBeforeCheckInScreenState(this._args);

  @override
  void initState() {
    BlocProvider.of<CheckInBloc>(context).add(FetchLocationEvent(args: _args));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return BlocListener<CheckInBloc, CheckInState>(
        listener: (BuildContext context, CheckInState state) {
          if (state is Fetching) {
            setState(() {
              _fetching = true;
            });
          }
          if (state is FetchSuccess) {
            setState(() {
              _fetching = false;
              _location = state.location;
            });
          }
          if (state is FetchFailed) {
            _fetching = false;
            print(state.error);
          }
          if (state is InvalidQR) {
            setState(() {
              _fetching = false;
              _isInvalidUrl = true;
            });
          }
        },
        cubit: Provider.of<CheckInBloc>(context),
        child: Scaffold(
          appBar: AppBar(
            // backgroundColor: Colors.transparent,
            title: Text("Safe Check In"),
            backgroundColor: Colors.grey[300],
          ),
          body: _isInvalidUrl
              ? _buildInvalidUrlBody(context)
              : Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: screenWidth * 0.06,
                      right: screenWidth * 0.06),
                  child: Center(
                    child: ListView(
                      children: [
                        _fetching ? LinearProgressIndicator() : Container(),
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
                          child: _buildLocationDetails(
                            context,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'By Check-In, I declare that:\n\n'),
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
                              TextSpan(
                                  text: '      - Difficulty in Breathing\n'),
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
                                Navigator.pushNamed(
                                    context, '/safeentrycheckin');
                                //CALL CHECK IN FUNCTION
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  Widget _buildInvalidUrlBody(BuildContext context) {
    return Center(
      child: Text("Invalid QR code scanned"),
    );
  }

  Widget _buildLocationDetails(BuildContext context) {
    if (_location == null) return Container();

    var title = "";
    var subtitle = "";

    if (_location is LocationLocation) {
      LocationLocation location = _location as LocationLocation;
      title = location.name;
      subtitle = location.address;
    } else if (_location is BusLocation) {
      BusLocation location = _location as BusLocation;
      title = location.name;
      subtitle = location.busRouteNo + " - " + location.busNo;
    } else if (_location is TrainLocation) {
      TrainLocation location = _location as TrainLocation;
      title = location.trainName;
      subtitle = location.trainNo;
    } else if (_location is VehicleLocation) {
      VehicleLocation location = _location as VehicleLocation;
      title = location.name;
      subtitle = location.vehicleNo;
    }

    return ListTile(
      tileColor: Colors.grey[200],
      title: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.black54, fontSize: 15),
      ),
      enabled: false,
    );
  }
}
