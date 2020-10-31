import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class SignupScreen extends StatefulWidget {
  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false;

  SignupScreenState();

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('images/signup.png');
    Image image = Image(
      image: assetImage,
      width: screenWidth*0.8,
      height: screenHeight*0.3,
    );

    return Scaffold(
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Container(height: 50),
                Center(
                  child: Text(
                    "To get started we need following",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 20),
                  ),
                ),
                Center(
                  child: Container(
                    child: image,
                  ),
                ),

                //Phone Number Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, vertical: 8.0),
                  child: TextFormField(
                    controller: numberController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Phone number is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),)
                    ),
                  ),
                ),

                //NIC Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, vertical: 8.0),
                  child: TextFormField(
                    controller: nicController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "NIC is required";
                      }
                      return null;
                    },
                    // keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'NIC',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),)
                    ),
                  ),
                ),

                //Password Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.05, vertical: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.4),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),)
                    ),
                  ),
                ),

                //Login button
                if (isLoading)
                  Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ))
                else
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.18, vertical: 30.0),
                    child : ButtonTheme(
                      height: 50,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)
                        ),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text(
                          'Sign Up',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              // call sign up function
                            }
                          });
                        },
                      ),
                    ),

                  ),
              ],
            ),
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}
