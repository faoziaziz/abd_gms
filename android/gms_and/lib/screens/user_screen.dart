import 'package:flutter/material.dart';
import 'package:gms_and/widgets/user/commons.dart';

class UserScreen extends StatefulWidget {
  static const routeName = '/userscreen';
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Screen'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Commons(),
    );
    ;
  }
}
