import 'package:flutter/material.dart';

class CustomPopButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Center(child: Icon(Icons.close)),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
