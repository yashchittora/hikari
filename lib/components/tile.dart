// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable
import 'package:flutter/material.dart';
import 'package:hikari/models/crud.dart';
import 'package:hikari/pages/edit.dart';
import 'package:provider/provider.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';


class NoteTile extends StatelessWidget {
  int id;
  String data;
  String title;
  // final database;
  TextEditingController titleController;
  TextEditingController dataController;

  NoteTile(
      {super.key,
      required this.data,
      required this.title,
      required this.id,
      required this.titleController,
      required this.dataController});

  @override
  Widget build(BuildContext context) {
      final database = context.watch<NoteDatabase>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25),
      child: GestureDetector(
        onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNotePage(
                                  id: id,
                                  data: data,
                                  title: title,
                                  database: database,
                                  titleController: titleController,
                                  dataController: dataController,
                                )));
                      },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CHILD 1 ----- TEXT with overflow handling
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiary,
                    ),// Adjust maxLines for desired number of lines
                  ),
                ),
              ),

              // CHILD 2 ----- Buttons
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditNotePage(
                                  id: id,
                                  data: data,
                                  title: title,
                                  database: database,
                                  titleController: titleController,
                                  dataController: dataController,
                                )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.edit),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        database.moveToTrash(id);
                        final snackBar = SnackBar(
                  /// need to set following properties for best effect of awesome_snackbar_content
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Moved To Trash !',
                    message:
                        'Your note is in trash !',

                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                    contentType: ContentType.warning,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
