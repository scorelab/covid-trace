import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:slcovid_tracker/states/upload_bloc/upload_bloc.dart';

class UploadScreen extends StatefulWidget {
  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  var _uploadFormKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentText = "";

  bool _loading = false;
  String _code;

  @override
  void initState() {
    BlocProvider.of<UploadBloc>(context).add(GetExposedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    var screenHeight = _mediaQueryData.size.height;
    AssetImage assetImage = AssetImage('asset/images/uploadscreen.png');
    Image image1 = Image(
      image: assetImage,
      width: screenWidth,
      height: screenHeight * 0.32,
    );

    TextEditingController _codeController = TextEditingController();

    return BlocListener<UploadBloc, UploadState>(
      listener: (BuildContext context, UploadState state) {
        if (state is Loading) {
          setState(() {
            this._loading = true;
          });
        }
        if (state is NonInfected) {
          setState(() {
            this._loading = false;
            this._code = null;
          });
        }
        if (state is NoCode) {
          _showDialog('Can be infected!', "Try again later for a code.");
          setState(() {
            this._loading = false;
            this._code = null;
          });
        }
        if (state is GotCode) {
          this._loading = false;
          this._code = state.code;
        }
        if (state is DataUploadFailed) {
          _showDialog('Upload Failed!', "Something went wrong, try again.");
          this._loading = false;
        }
        if (state is DataUploadSuccess) {
          _showDialog('Upload Successfull!', "Thanks for your cooperation.");
          this._loading = false;
          this._code = null;
        }
      },
      cubit: Provider.of<UploadBloc>(context),
      child: Scaffold(
        appBar: new AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffd9d9d9),
          title: Center(
              child: Text(
                  _code != null
                      ? "Marked as Infector "
                      : "Not Marked as Infector",
                  textAlign: TextAlign.center)),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: ListView(
            children: [
              image1,
              _code != null
                  ? _buildInfected(context)
                  : _buildNonInfected(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfected(BuildContext context) {
    return Form(
      key: _uploadFormKey,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color(0xffff7e78),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "You are infected with Covid-19.\nType this code to upload your data for contact tracing",
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "$_code",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 17),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
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
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ))
                : RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    onPressed: _onUpload,
                    color: Color(0xff1DE9B6),
                    textColor: Colors.white,
                    child: Text("Submit", style: TextStyle(fontSize: 25)),
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildNonInfected(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
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
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2,
                ),
                Text(
                  "An upload code is given to patients with Covid-19.",
                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "If you didn’t get a code, you do not need to upload data!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: _loading
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                ))
              : RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  onPressed: _checkInfected,
                  color: Color(0xff1DE9B6),
                  textColor: Colors.white,
                  child: Text("Check Infected", style: TextStyle(fontSize: 25)),
                ),
        )
      ],
    );
  }

  void _checkInfected() {
    BlocProvider.of<UploadBloc>(context).add(GetCodeEvent());
  }

  void _onUpload() {
    setState(() {
      if (_uploadFormKey.currentState.validate()) {
        if (currentText != _code) {
          _showDialog('Error Occured!',
              "The code you entered is invalid. Please check your information and try again");
        } else {
          BlocProvider.of<UploadBloc>(context)
              .add(UploadDataEvent(code: _code));
        }
        //method
      }
    });
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text(
          title,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        content:
            Text(message, style: TextStyle(fontSize: 18, color: Colors.white)),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); // dismisses only the dialog and returns nothing
            },
            child: new Text(
              'OK',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
