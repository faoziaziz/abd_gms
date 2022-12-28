import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gms_and/screens/check_screen.dart';
import 'package:gms_and/widgets/user/anasiskesehatan.dart';
import 'package:gms_and/widgets/user/scan_qr.dart';
import 'package:gms_and/widgets/user/anasiskesehatan.dart';

import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:gms_and/widgets/chart.dart';
import 'package:gms_and/widgets/book_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

import 'package:provider/provider.dart';
import 'package:gms_and/models/notes_operation.dart';

class Commons extends StatefulWidget {
  @override
  _CommonState createState() => _CommonState();
}

class _CommonState extends State<Commons> {
  final GlobalKey qrKey = GlobalKey();
  String barcode = "";
  double valGlucose = 12.0;
  bool _isDispGlucose = true;
  int _test = 1;
  bool _isdisplayQR = false;
  bool _isAnalisysDisplay = false;

  void growTest() {
    setState(() {
      _test += 1;
    });
  }

  void _qrDisplay() {
    setState(() {
      _isdisplayQR = !_isdisplayQR;
    });
  }

  void _analisysDisplay() {
    setState(() {
      _isAnalisysDisplay = !_isAnalisysDisplay;
    });
  }

  void checkPage(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CheckScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle styleButton = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );

    return Column(
      children: <Widget>[
        //AddText(),
        //BookChart(),
        Center(
          child: Text("Ini analisa kesehatan anda selama ini"),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  //style: styleButton,
                  onPressed: () => _qrDisplay(),
                  child: Row(
                    children: <Widget>[
                      Text("Check glukosa lagi"),
                      _isdisplayQR
                          ? Icon(Icons.arrow_circle_up)
                          : Icon(Icons.arrow_circle_down),
                    ],
                  ),
                ),
              ),
              _isdisplayQR ? ScanQR() : Text("gak nampil"),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  //style: styleButton,
                  onPressed: () => _analisysDisplay(),
                  child: Row(
                    children: <Widget>[
                      Text("Anakes"),
                      _isAnalisysDisplay
                          ? Icon(Icons.arrow_circle_up)
                          : Icon(Icons.arrow_circle_down),
                    ],
                  ),
                ),
              ),
              _isAnalisysDisplay ? AnaKes() : Text("gak nampil"),
              //AddText(),
            ],
          ),
        ),
      ],
    );
  }
}
