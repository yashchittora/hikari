// ignore_for_file: prefer_initializing_formals
import 'package:isar/isar.dart';
part 'note.g.dart';

@collection
class Note{
  Id id = Isar.autoIncrement;
  late String? noteData;
  late String? noteTitle;
  

  Note(String? noteTitle,String? noteData){
    this.noteTitle = noteTitle;
    this.noteData = noteData;
  }
}

// @collection
// class thememode{
//   Id id = Isar.autoIncrement;
//   late ThemeData mode;
  
//   thememode(ThemeData mode){
//     this.mode = mode;
//   }
// }