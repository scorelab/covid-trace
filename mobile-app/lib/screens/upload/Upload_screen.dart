import 'package:flutter/material.dart';
import 'package:slcovid_tracker/widgets/bottom_navgiation.dart';
import 'package:slcovid_tracker/widgets/label_text_form_field.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var _uploadFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool _infected = true;
    int _code = 957181;
    TextEditingController _codeController = TextEditingController();
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/uploadscreen.png');
    Image image1 = Image(
      image: assetImage,
      width: screenWidth,
      height: screenHeight * 0.32,
    );
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffd9d9d9),
        title: Center(
            child: Text("Marked as Infector ", textAlign: TextAlign.center)),
      ),
      bottomNavigationBar: AppBottomNavbar(),
      body: Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.05, left: 10, right: 10),
        child: Center(
          child: ListView(
            children: <Widget>[
              Form(
                key: _uploadFormKey,
                child: Column(
                  children: [
                    image1,
                    Container(
                      height: 120,
                      width: screenWidth * 0.8,
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "An upload code is given to patients with Covid-19.",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal, fontSize: 16),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "If you didn’t get a code, you do not need to upload data!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _infected
                        ? Text(
                            "We have identified you as a patient \n Use this code:- $_code ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                                fontSize: 20),
                          )
                        : Text(
                            "You are not infected",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff626262),
                                fontSize: 25),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    LabelTextFormField(
                      labelText: "Code",
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenWidth * 0.7, // specific value
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_uploadFormKey.currentState.validate()) {
                              //method
                            }
                          });
                        },
                        color: Color(0xff1DE9B6),
                        textColor: Colors.white,
                        child: Text("Submit", style: TextStyle(fontSize: 25)),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
