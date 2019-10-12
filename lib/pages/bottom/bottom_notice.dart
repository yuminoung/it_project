import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BottomNotice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<BottomNotice> {
  @override
  Widget build(BuildContext context) {
    return Center (child: Text("IT Project", style: TextStyle(fontSize: 34.0),),);
  }
}