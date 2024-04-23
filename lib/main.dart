// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:hikari/models/crud.dart';
import 'package:hikari/pages/home.dart';
import 'package:hikari/pages/settings.dart';
import 'package:hikari/themes/theme.dart';
import 'package:hikari/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.init();

  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context)=> NoteDatabase()),
      ChangeNotifierProvider(create: (context)=> ThemeProvider()),

      ],
    child: const Hikari(),)
    );
}

class Hikari extends StatelessWidget {
  const Hikari({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hikari",
      home: HomePage(),
      theme: Provider.of<ThemeProvider>(context) .themeData,
      routes: {
        '/settingspage':(context) => SettingsPage(),
      },
    );
  }
}
