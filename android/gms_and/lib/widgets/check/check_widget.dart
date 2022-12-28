import 'package:flutter/material.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Text("Scan QR"),
          ),
          Container(
            child: Text("Status Scanning "),
          ),
          Container(
            child: Text("the result "),
          ),
        ],
      ),
    );
  }
}
