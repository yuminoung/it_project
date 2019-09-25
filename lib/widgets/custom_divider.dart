import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).canvasColor,
      height: 8,
      thickness: 8,
    );
  }
}
