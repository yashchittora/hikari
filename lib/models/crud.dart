import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:hikari/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  
  // Initialize
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> current_notes = [];

  // Create
  Future<void> pushNote(String? title, String? userinput) async {
    if (title == "") {
      title = "Untitled Note";
    }
    Note temp = Note(title, userinput);
    await isar.writeTxn(() => isar.notes.put(temp));
    pullNotes();
  }

  // Read
  Future<void> pullNotes() async {
    List<Note> pulledNotes = await isar.notes.where().findAll();
    current_notes.clear();
    current_notes.addAll(pulledNotes);
    notifyListeners();
  }

  // Update
  Future<void> updateNote(int id, String newTitle, String userinput) async {
    final temp = await isar.notes.get(id);
    if (temp != null) {
      temp.noteTitle = newTitle;
      temp.noteData = userinput;
      await isar.writeTxn(() => isar.notes.put(temp));
    }
    pullNotes();
  }

  // Delete
  Future<void> deleteNote(int id) async {
    final temp = await isar.notes.get(id);
    if (temp != null) {
      isar.writeTxn(() => isar.notes.delete(id));
    }
    pullNotes();
  }

  // Note single_temp = Note(null, null);
  // Future<void> pullById(int id) async {
  //   final pulled = await isar.notes.get(id);
  //   if (pulled != null) {
  //     single_temp.noteTitle = pulled.noteTitle;
  //     single_temp.noteData = pulled.noteData;
  //   }
  // }
  //Depreciated method used for fetching data for opening existing note


}
