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