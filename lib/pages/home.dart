import 'package:flutter/material.dart';
import 'package:hikari/components/tile.dart';
import 'package:hikari/models/crud.dart';
import 'package:hikari/models/note.dart';
import 'package:hikari/pages/new.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    final database = context.watch<NoteDatabase>();
    database.pullNotes();
    List<Note> notes = database.current_notes;

    void newNote() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => NewNotePage(
            database: database,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          "Hikari",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          newNote();
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                'Your Notes',
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
                return NoteTile(
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
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18)
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset('lib/images/logo.png',)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),

                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, '/settingspage');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
