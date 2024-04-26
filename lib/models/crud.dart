import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:hikari/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  static late Isar trash;
  // static late Isar themeModeData;

  
  // Initialize
  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);

    isar = await Isar.open(name: 'isar',[NoteSchema],directory: dir.path);
    trash = await Isar.open(name: 'trash',[NoteSchema],directory: dir.path);
    // themeModeData = await Isar.open(name: 'thememode',[ThememodeSchema],directory: dir.path);

  }

  final List<Note> current_notes = [];
  final List<Note> trash_notes = [];
  // final List<thememode> themelist = [];
  // late ThemeData apptheme;


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

    List<Note> pulledTrashNotes = await trash.notes.where().findAll();
    trash_notes.clear();
    trash_notes.addAll(pulledTrashNotes);

    // List<thememode> pulledThemeList = await themeModeData.thememodes.where().findAll();
    // themelist.clear();
    // themelist.addAll(pulledThemeList);
    // apptheme=themelist[0].mode;
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
    final temp = await trash.notes.get(id);
    if (temp != null) {
      trash.writeTxn(() => trash.notes.delete(id));
    }
    pullNotes();
  }

  Future<void> moveToTrash(int id) async {
    final temp = await isar.notes.get(id);
    if (temp != null) {
      isar.writeTxn(() => isar.notes.delete(id));
      await trash.writeTxn(() => trash.notes.put(temp));
    }
    pullNotes();
  }

  Future<void> restore(int id) async {
    final temp = await trash.notes.get(id);
    if (temp != null) {
      await isar.writeTxn(() => isar.notes.put(temp));
      trash.writeTxn(() => trash.notes.delete(id));
    }
    pullNotes();
  }

  // Future<void> changeTheme(ThemData mode) async {
  //   final temp = await themeModeData.thememodes.get(0);
  //   if (temp != null) {
  //     temp.mode = mode;
  //     await isar.writeTxn(() => themeModeData.thememodes.put(temp));
  //   }
  //   pullNotes();
  // }



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

// Future<void> initTheme() async {
//   int id = 0;
//     final temp = await themeModeData.thememodes.get(id);
//     if (temp == null) {
//       thememode temp = thememode(lightMode);
//       await isar.writeTxn(() => themeModeData.thememodes.put(temp));
//     }
//     if(temp!=null){
//       if(temp.mode == lightMode){
//         temp.mode=darkMode;
//       } else{
//         temp.mode=lightMode;
//       }
//       await isar.writeTxn(() => themeModeData.thememodes.put(temp));
//     }
//     pullNotes();
// }