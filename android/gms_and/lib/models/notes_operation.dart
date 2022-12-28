import 'package:flutter/cupertino.dart';
import 'package:gms_and/models/note.dart';

class NotesOperation with ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get getNotes {
    return _notes;
  }

  NotesOperation() {
    addNewNote('First Note', 'First Note Description');
  }

  void addNewNote(String email, String uid) {
    Note note = Note(email, uid);
    _notes.add(note);
    notifyListeners();
  }
}
