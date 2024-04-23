import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    tertiary: Colors.blue.shade400,
    background: Colors.grey.shade100,
  )
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Colors.grey.shade600,
    secondary: Colors.grey.shade800,
    tertiary: Colors.blue.shade300
  )
);