import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cfs;

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works !'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          cfs.FirebaseFirestore.instance
              .collection('chats/5Yu3wXLvuA4zk8Ebzo01/messages')
              .snapshots()
              .listen((data) {
            print(data);
          });
        },
      ),
    );
  }
}
