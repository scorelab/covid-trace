import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';
import 'package:slcovid_tracker/states/checkin_bloc/checkin_bloc.dart';
import 'package:slcovid_tracker/states/exposed_bloc/exposed_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: Center(
          child: ListView(
            children: [
              Center(
                child: Container(
                  child: image,
                ),
              ),
              StreamBuilder(
                  stream: BlocProvider.of<ExposedBloc>(context).isExposed,
                  builder: _buildIsExposed),
              StreamBuilder(
                  stream:
                      BlocProvider.of<CheckInBloc>(context).checkedInLocations,
                  builder: _buildCurrentCheckIn),
              Container(
                height: 70,
                margin: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1, vertical: 5.0),
                child: Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 10, right: 10),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.login_rounded,
                              color: Colors.red,
                              size: 30.0,
                            ),
                            Text(
                              "Safe In",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                            SizedBox(
                              height: 30,
                              width: screenWidth * 0.4, // specific value
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0.0),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.checkin);
                                  // Navigator.pushNamed(
                                  //     context, Routes.safeentrybeforecheckin,
                                  //     arguments: SafeEntryBeforeCheckInScreenArgs(
                                  //         ("https://safecheckin.com/sc_bus/AXeyPFiEpYBGIfyasNGr?name=Nimal")));
                                },
                                color: Color(0xff1DE9B6),
                                textColor: Colors.white,
                                child: Text(
                                  "NEW SAFE IN",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIsExposed(context, AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasData && snapshot.data) {
      return _safedetails(
        icon: Icons.warning,
        col: Colors.red,
        title: 'Alert',
        subtile:
            "You're exposed to Covid-19 positive\n person, Don't worry. Please contact\n the authorities and self-quarantine.",
        heightfactor: 90.0,
      );
    } else {
      return _safedetails(
        icon: Icons.beenhere_outlined,
        title: 'You are ok',
        col: Theme.of(context).primaryColor,
        subtile: 'Based on all your Safe-In\n records from the last 14 days.',
        heightfactor: 80.0,
      );
    }
  }

  Widget _buildCurrentCheckIn(context, AsyncSnapshot<List<Location>> snapshot) {
    if (!snapshot.hasData || snapshot.data.length <= 0) {
      return _buildNotCheckedIn(context);
    }
    Location lastCheckIn = snapshot.data[0];
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    return Container(
      height: 120,
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: 2.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Last QR Safe In',
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                lastCheckIn.name,
                //Location name should be replaced
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 30,
                    width: screenWidth * 0.35, // specific value
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      onPressed: () => _onViewPass(lastCheckIn),
                      color: Colors.grey,
                      textColor: Colors.white,
                      child: Text(
                        "VIEW PASS",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: screenWidth * 0.35, // specific value
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      onPressed: () => _onCheckOut(lastCheckIn),
                      color: Color(0xff1DE9B6),
                      textColor: Colors.white,
                      child: Text(
                        "SAFE OUT",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Let's stand together",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          // Image(
          //   image: assetImage2,
          //   width: 64,
          // ),
        ],
      ),
    );
  }
}

class _safedetails extends StatelessWidget {
  const _safedetails(
      {@required this.title,
      @required this.heightfactor,
      @required this.subtile,
      @required this.icon,
      @required this.col});

  final String title;
  final String subtile;
  final IconData icon;
  final Color col;
  final double heightfactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
        shape: BoxShape.rectangle,
        color: Color(0xffd9d9d9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: col,
                  size: 50.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      subtile,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
