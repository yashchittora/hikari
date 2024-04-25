import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hikari/themes/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(title: Text("Settings"),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.secondary,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Dark Mode"),
                    CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, onChanged: (value){
                      Provider.of<ThemeProvider>(context, listen: false).toggleThemes();
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
