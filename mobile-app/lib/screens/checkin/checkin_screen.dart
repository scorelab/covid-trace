import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:slcovid_tracker/routing/routes.dart';
import 'package:slcovid_tracker/screens/safeentrybeforecheckin/safeentrybeforecheckin_screen.dart';

class CheckInScreen extends StatefulWidget {
  @override
  _CheckInScreenState createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final String baseUrl = 'https://safecheckin.com';
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if (scanData.contains(baseUrl)) {
          controller?.dispose();
          Navigator.pushReplacementNamed(context, Routes.safeentrybeforecheckin,
              arguments: SafeEntryBeforeCheckInScreenArgs((scanData)));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        title: Text(""),
        backgroundColor: Colors.grey[300],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            top: 20, left: screenWidth * 0.06, right: screenWidth * 0.06),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Text('Scanning'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
