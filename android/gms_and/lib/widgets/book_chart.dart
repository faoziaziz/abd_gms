import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').snapshots(),
      builder: (ctx, bookSnapshot) {
        if (bookSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = bookSnapshot.data.documents;
        return ListView.builder(
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => Text(
            chatDocs[index]['text'],
          ),
        );
      },
    );
  }
}
