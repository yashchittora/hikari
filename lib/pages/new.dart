// ignore_for_file: prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class NewNotePage extends StatelessWidget {
  final database;

  const NewNotePage(
      {super.key,
      // required this.titleController,
      // required this.dataController,
      required this.database
      }
    );


  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController dataController = TextEditingController();



    return Scaffold(
      appBar: AppBar(
        leading: IconButton(tooltip: "Back" , icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () async {
                  await database.pushNote(titleController.text.toString(),
                      dataController.text.toString());

                  Navigator.of(context).pop();
                  final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Saved !',
                    message:
                        'Your thoughts are safe!',
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
                },),
          backgroundColor: Theme.of(context).colorScheme.primary,

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.tertiary), // Set any color you like
                ),
                onPressed: () async {
                  await database.pushNote(titleController.text.toString(),
                  dataController.text.toString());
                  Navigator.of(context).pop();
                  final snackBar = SnackBar(
                  elevation: 0,
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Saved !',
                    message:
                        'Your thoughts are safe!',
                    contentType: ContentType.success,
                  ),
                );

                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              },
                child: const Row(
                  children: [
                    Icon(Icons.check),
                    Text(' Save'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.grey), // Set any color you like
                ),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: const Row(
                  children: [
                    Icon(Icons.cancel),
                    Text(' Cancel'),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title...",
                  hintStyle:
                      TextStyle(fontSize: 32, color: Colors.grey.shade500),
                  border: InputBorder.none
                ),
                style: const TextStyle(
                  fontSize: 32,
                ),
                scrollPadding: const EdgeInsets.all(20.0),
                autofocus: true,
              ),
              Expanded(
                  child: TextField(
                controller: dataController,
                decoration: InputDecoration(
                    hintText: "Write something amazing...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none),
                scrollPadding:const EdgeInsets.all(20.0),
                autofocus: true,
                maxLines: 100000,
              ))
            ],
          ),
        ));
  }
}
