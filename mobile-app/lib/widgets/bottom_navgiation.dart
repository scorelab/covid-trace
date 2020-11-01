import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//bottm navigation  bar
class AppBottomNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.graduationCap, size: 25),
            label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.history, size: 25), label: 'History'),
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
        switch (idx) {
          case 0:
            //Add routes here
            break;
          case 1:
            //Add routes here
            break;
          case 2:
            //Add routes here
            break;
          case 3:
            //Add routes here
            break;
        }
      },
    );
  }
}
