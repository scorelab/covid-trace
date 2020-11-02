import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _phonenumber = 7182932;
  String _nic = "1994*****020";
  bool _numberverfied = true;
  String _dropDownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffd9d9d9),
        title: Center(child: Text("Profile", textAlign: TextAlign.center)),
      ),
      bottomNavigationBar: AppBottomNavbar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _profiledetails(
                icon: Icons.phone,
                label: "Phone Number",
                value: "+94" + "$_phonenumber",
                button: true,
                verfied: _numberverfied,
              ),
              SizedBox(
                height: 35,
              ),
              _profiledetails(
                icon: FontAwesomeIcons.addressCard,
                label: "NIC",
                value: "$_nic",
                button: false,
              ),
              SizedBox(
                height: 50,
              ),
              Text("Help and Feedback",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22)),
              SizedBox(
                height: 30,
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
                height: 30,
              ),
              Text("Change Language",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 22)),
              SizedBox(
                height: 20,
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
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
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

class _profiledetails extends StatelessWidget {
  final String label;
  final bool button;
  final IconData icon;
  final String value;
  final bool verfied;

  const _profiledetails(
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
                            onPressed: () {},
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
}
