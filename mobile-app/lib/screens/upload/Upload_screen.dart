import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var _uploadFormKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";

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
      height: _infected ? screenHeight * 0.32 : screenHeight * 0.32,
    );
    return Scaffold(
      appBar: new AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffd9d9d9),
        title: Center(
            child: Text("Marked as Infector ", textAlign: TextAlign.center)),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: _infected ? screenHeight * 0.03 : screenHeight * 0.03,
            left: 10,
            right: 10),
        child: Center(
          child: ListView(
            children: <Widget>[
              Form(
                key: _uploadFormKey,
                child: Column(
                  children: [
                    image1,
                    SizedBox(
                      height: 20,
                    ),
                    _infected
                        ? Container(
                            height: 80,
                            width: screenWidth * 0.9,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(0xffff8170),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 2.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "You are infected with Covid-19 Type this code to upload your data for contact tracing",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "$_code",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              Container(
                                height: 80,
                                width: screenWidth * 0.9,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                  shape: BoxShape.rectangle,
                                  color: Color(0xffd9d9d9),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "An upload code is given to patients with Covid-19.",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 13),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "If you didn’t get a code, you do not need to upload data!",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "You are not infected with Covid-19",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff626262),
                                    fontSize: 22),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: screenWidth * 0.9,
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 6,
                        obscureText: false,
                        obscuringCharacter: '*',
                        validator: (v) {
                          if (v.length < 6) {
                            return "Please enter the code correctly";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          inactiveColor: Colors.grey,
                          inactiveFillColor: Colors.transparent,
                          activeFillColor: Colors.transparent,
                          activeColor: Colors.black54,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(2),
                          fieldHeight: 60,
                          fieldWidth: 50,
                        ),
                        cursorColor: Colors.black,
                        textStyle: TextStyle(fontSize: 20, height: 1.6),
                        keyboardType: TextInputType.number,
                        onCompleted: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 50,
                      width: screenWidth * 0.9, // specific value
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_uploadFormKey.currentState.validate()) {
                              if (int.parse(currentText) != _code &&
                                  _infected == true) {
                                showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    title: new Text(
                                      'Error Occured!',
                                      style: TextStyle(
                                          fontSize: 25, color: Colors.white),
                                    ),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    content: Text(
                                        "The code you entered is invalid. Please check your information and try again",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white)),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(); // dismisses only the dialog and returns nothing
                                        },
                                        child: new Text(
                                          'OK',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
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
