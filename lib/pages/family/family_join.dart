import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';

class FamilyJoin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomIconButton(
          icon: Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: 'Join a family',
      ),
      body: Container(
        child: Text('Create a family'),
      ),
    );
  }
}
