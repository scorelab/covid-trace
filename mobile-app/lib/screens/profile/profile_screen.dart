import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/models/user.dart';
import 'package:slcovid_tracker/routing/application.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/states/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (!(state is Authenticated)) return Container();

      User _user = (state as Authenticated).user;

      return Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffd9d9d9),
          title: Center(child: Text("Profile", textAlign: TextAlign.center)),
        ),
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 35, right: 35),
            child: ListView(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _ProfileDetails(
                        icon: Icons.phone,
                        label: "Phone Number",
                        value: _user != null ? "${_user.phoneNumber}" : "",
                        button: true,
                        verfied: _user != null && _user.numberVerified,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  _ProfileDetails(
                    icon: FontAwesomeIcons.addressCard,
                    label: "NIC",
                    // TODO - Get the real NIC instead of hash
                    value: _user != null ? "${_user.nic.substring(0, 20)}" : "",
                    button: false,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Help and Feedback",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22)),
                  SizedBox(
                    height: 10,
                  ),

                  _Helpandfeedbackitems(
                    name: "Report a Problem",
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _Helpandfeedbackitems(
                    name: "Help",
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Change Language",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 22)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Selected Language",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 20)),
                      DropdownButton(
                        items: <String>[
                          'English',
                          'සිංහල',
                          'தமிழ்',
                        ].map((String value) {
                          return new DropdownMenuItem<String>(
                            value: value,
                            child: new Text(value),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(
                            () {
                              _dropDownValue = val;
                            },
                          );
                        },
                        hint: _dropDownValue == null
                            ? Text('English')
                            : Text(
                                _dropDownValue,
                              ),
                      ),
                    ],
                  ),
                  //Logout removed
                  // ButtonTheme(
                  //   height: 50,
                  //   child: RaisedButton(
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(30.0)),
                  //     color: Theme.of(context).primaryColor,
                  //     textColor: Colors.white,
                  //     child: Text(
                  //       'Sign Out',
                  //       textScaleFactor: 1.5,
                  //     ),
                  //     onPressed: () {
                  //       _signOut(context);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ]),
          ),
        ),
      );
    });
  }

  void _signOut(context) {
    BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
    Application.router.navigateTo(context, Routes.signin, clearStack: true);
  }
}

class _Helpandfeedbackitems extends StatelessWidget {
  final String name;
  const _Helpandfeedbackitems({this.name});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name,
            style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 20)),
        Icon(
          Icons.arrow_forward,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }
}

class _ProfileDetails extends StatelessWidget {
  final String label;
  final bool button;
  final IconData icon;
  final String value;
  final bool verfied;

  const _ProfileDetails(
      {this.icon, this.label, this.value, this.button, this.verfied});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.black45,
          size: 35.0,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25)),
            Text(value,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 18)),
            button
                ? verfied
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ButtonTheme(
                          minWidth: 150.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: null,
                            disabledColor: Theme.of(context).primaryColor,
                            disabledTextColor: Colors.white,
                            child: Text("Verified",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: ButtonTheme(
                          minWidth: 150.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              _verifyPhone(context);
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text("Not Verified",
                                style: TextStyle(fontSize: 20)),
                          ),
                        ),
                      )
                : SizedBox(),
          ],
        )
      ],
    );
  }

  void _verifyPhone(context) {
    Application.router.navigateTo(context, Routes.verification);
  }
}
