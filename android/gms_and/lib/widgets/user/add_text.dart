import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gms_and/models/notes_operation.dart';
import 'package:gms_and/widgets/user/qr.dart';
import 'package:gms_and/models/note.dart';

class AddText extends StatelessWidget {
  late String _titleText;
  late String _descriptionText;
  AddText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Provider test"),
        TextField(
          decoration: InputDecoration(
            hintText: 'Title',
          ),
          onChanged: (value) {
            _titleText = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Description',
          ),
          onChanged: (value) {
            _descriptionText = value;
          },
        ),
        TextButton(
          onPressed: () {
            Provider.of<NotesOperation>(context, listen: false)
                .addNewNote(_titleText, _descriptionText);
            //Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CardText(),
            ));
          },
          child: Text('Add notes'),
        ),
      ],
    );
  }
}

class CardText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text(
          'Task Manager',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<NotesOperation>(
        builder: (context, NotesOperation data, child) {
          return ListView.builder(
            itemCount: data.getNotes.length,
            itemBuilder: (context, index) {
              return NotesCard(data.getNotes[index]);
            },
          );
        },
      ),
    );
  }
}

class NotesCard extends StatelessWidget {
  final Note note;

  NotesCard(this.note);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            note.description,
            style: TextStyle(fontSize: 17),
          ),
        ],
      ),
    );
  }
}
