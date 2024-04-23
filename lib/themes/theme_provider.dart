import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hikari/themes/theme.dart';

class ThemeProvider with ChangeNotifier{
  ThemeData themeDataMain = lightMode;

  ThemeData get themeData => themeDataMain;

  bool get isDarkMode => themeDataMain==darkMode;

  set themeData(ThemeData themeData){
    themeDataMain = themeData;
    notifyListeners();
  }

  void toggleThemes(){
    if(themeDataMain==lightMode){
      themeData = darkMode;
    }
    else{
      themeData = lightMode;
    }
  }

}