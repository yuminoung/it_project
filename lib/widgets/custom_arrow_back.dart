import 'package:flutter/material.dart';

class CustomArrowBack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Center(child: Icon(Icons.arrow_back)),
      onTap: () {
        FocusScope.of(context).unfocus();
        Navigator.pop(context);
      },
    );
  }
}