import 'package:flutter/material.dart';

final themeData = ThemeData(
  primaryColor: Colors.red,
  // canvasColor: Color.fromRGBO(240, 240, 240, 1),
  accentColor: Colors.redAccent,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.red),
  textTheme: TextTheme(
    title: TextStyle(fontFamily: 'RobotoMono', fontSize: 24),
  ),
);
