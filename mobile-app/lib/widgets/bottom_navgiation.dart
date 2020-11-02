import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//bottm navigation  bar
class AppBottomNavbar extends StatefulWidget {
  @override
  _AppBottomNavbarState createState() => _AppBottomNavbarState();
}

int _selectedIndex = 0;

class _AppBottomNavbarState extends State<AppBottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.home, size: 25), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.history, size: 25), label: 'History'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.exclamationTriangle, size: 25),
            label: 'Upload'),
        BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user, size: 25), label: 'Profile'),
      ].toList(),

      /*Still There is problem.When You pressed back buton it will go to the revlevent back 
      page but wont change selected item color.Will Check it soon*/
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Color(0xff626262),
      onTap: (int idx) {
        setState(() {
          _selectedIndex = idx;
        });
        switch (idx) {
          case 0:
            Navigator.pushNamed(context, '/home');
            break;
          case 1:
            Navigator.pushNamed(context, '/history');
            break;
          case 2:
            Navigator.pushNamed(context, '/upload');
            break;
          case 3:
            Navigator.pushNamed(context, '/profile');
            break;
        }
      },
    );
  }
}
