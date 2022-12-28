import 'package:flutter/material.dart';

class CheckScreen extends StatefulWidget {
  static const routeName = '/check';
  const CheckScreen({super.key});

  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Glucose Checking'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          )
        ],
      ),
    );
  }
}
