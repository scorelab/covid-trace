import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/checkin_bloc/checkin_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool _safe = false;
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/home.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth,
    );

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: screenHeight * 0.03),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                  child: image,
                ),
              ),
              _safe
                  ? _safedetails(
                      screenWidth: screenWidth,
                      icon: Icons.beenhere_outlined,
                      title: 'You are ok',
                      col: Theme.of(context).primaryColor,
                      subtile:
                          'Based on all your Safe Check-In records from the last 14 days.',
                    )
                  : _safedetails(
                      screenWidth: screenWidth,
                      icon: Icons.warning,
                      col: Colors.red,
                      title: 'Alert',
                      subtile:
                          "You're exposed to Covid-19 positive person, Don't worry. Please contact the authorities and self-quarantine.",
                    ),
              Container(height: 5),
              StreamBuilder(
                  stream:
                      BlocProvider.of<CheckInBloc>(context).checkedInLocations,
                  builder: _buildCurrentCheckIn),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 8,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          Expanded(
                            flex: 4,
                            child: Icon(
                              Icons.login_rounded,
                              color: Colors.red,
                              size: 30.0,
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Text(
                              "Safe Check In",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ),
                          Expanded(
                            flex: 14,
                            child: ButtonTheme(
                              height: 40,
                              minWidth: screenWidth * 0.38,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: Text(
                                  'NEW CHECK IN',
                                  textScaleFactor: 1.2,
                                ),


                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Routes.checkin);
                                // Navigator.pushNamed(
                                //     context, Routes.safeentrybeforecheckin,
                                //     arguments: SafeEntryBeforeCheckInScreenArgs(
                                //         ("https://safecheckin.com/sc_bus|AXeyPFiEpYBGIfyasNGr|Namal Travels|NM-0001")));
                              },
                            ),
                          ),
                             ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                        ],
                      ),
                      Container(
                        height: 8,
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

  Widget _buildCurrentCheckIn(context, AsyncSnapshot<List<Location>> snapshot) {
    if (!snapshot.hasData || snapshot.data.length <= 0) {
      return _buildNotCheckedIn(context);
    }

    Location lastCheckIn = snapshot.data[0];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
                lastCheckIn.name,
                //Location name should be replaced
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.grey,
                    textColor: Colors.white,
                    child: Text(
                      'VIEW PASS',
                      textScaleFactor: 1.3,
                    ),
                    onPressed: () => _onViewPass(lastCheckIn),
                  ),
                ),
                ButtonTheme(
                  height: 40,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(
                      'CHECK OUT',
                      textScaleFactor: 1.3,
                    ),
                    onPressed: () => _onCheckOut(lastCheckIn),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onViewPass(Location location) {
    Navigator.pushNamed(context, Routes.safeentrycheckin, arguments: location);
  }

  void _onCheckOut(Location location) async {
    (await BlocProvider.of<CheckInBloc>(context).checkOut(location)).fold(
      (l) => null,
      (r) => Navigator.pushNamed(context, Routes.checkout, arguments: r),
    );
  }

  Widget _buildNotCheckedIn(context) {
    AssetImage assetImage2 = AssetImage('asset/images/slflag.png');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Let's stand together",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          Image(
            image: assetImage2,
            width: 64,
          ),
        ],
      ),
    );
  }
}

class _safedetails extends StatelessWidget {
  const _safedetails(
      {@required this.title,
      @required this.screenWidth,
      @required this.subtile,
      @required this.icon,
      @required this.col});

  final double screenWidth;
  final String title;
  final String subtile;
  final IconData icon;
  final Color col;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 20.0),
      child: ListTile(
        tileColor: Color(0xffd9d9d9),
        leading: Icon(
          icon,
          color: col,
          size: 50.0,
        ),
        title: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black87),
            children: <TextSpan>[
              TextSpan(text: subtile),
            ],
          ),
        ),
        enabled: false,
      ),
    );
  }
}
