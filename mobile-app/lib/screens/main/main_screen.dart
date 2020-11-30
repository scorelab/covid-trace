import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slcovid_tracker/screens/history/history_screen.dart';
import 'package:slcovid_tracker/screens/home/home_screen.dart';
import 'package:slcovid_tracker/screens/profile/profile_screen.dart';
import 'package:slcovid_tracker/screens/upload/upload_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomeScreen(),
    HistoryScreen(),
    UploadScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home, size: 25), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.history, size: 25),
                label: 'History'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.exclamationTriangle, size: 25),
                label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user, size: 25), label: 'Profile'),
          ].toList(),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Color(0xff626262),
          onTap: (int idx) {
            setState(() {
              _selectedIndex = idx;
            });
          },
        ),
        body: _pages.elementAt(_selectedIndex));
  }
}
