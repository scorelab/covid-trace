import 'package:flutter/material.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavbar(),
      body: Container(
        child: Center(
          child: Text("Profile screen"),
        ),
      ),
    );
  }
}
