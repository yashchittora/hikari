import 'package:flutter/material.dart';
import 'package:hikari/components/tile.dart';
import 'package:hikari/components/trashtile.dart';
import 'package:hikari/models/crud.dart';
import 'package:hikari/models/note.dart';
import 'package:hikari/pages/new.dart';
import 'package:provider/provider.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    final database = context.watch<NoteDatabase>();
    database.pullNotes();
    List<Note> notes = database.trash_notes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Hikari",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                'Trash',
                style: TextStyle(
                    // color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onTertiary,
                    ),
                textAlign: TextAlign.start,

              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return TrashTile(
                  title: notes[index].noteTitle.toString(),
                  data: notes[index].noteData.toString(),
                  id: notes[index].id,
                  dataController: dataController,
                  titleController: titleController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
