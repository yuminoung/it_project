import 'package:flutter/material.dart';

import 'routes.dart';
import 'theme.dart';

// Am I in the new branch?

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      home: routes['/landing'],
    );
  }
}
