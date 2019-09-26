import 'package:flutter/material.dart';
import 'package:it_project/widgets/all_widgets.dart';

class EditPost extends StatefulWidget {
  @override
  EditPostState createState() => EditPostState();
}

class EditPostState extends State<EditPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Post',
      ),
      body: Text('teat'),
    );
  }
}
