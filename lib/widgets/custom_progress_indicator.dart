import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Color.fromRGBO(250, 250, 250, 0),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
    );
  }
}
