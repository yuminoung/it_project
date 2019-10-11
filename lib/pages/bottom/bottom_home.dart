import 'dart:async';

import 'package:flutter/material.dart';
import 'package:it_project/providers/artifacts.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:provider/provider.dart';

class BottomHome extends StatefulWidget {
  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  var _isInit = true;
  Timer timer;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Artifacts>(context).fetchAndSetArtifacts().then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 15), (Timer timer) => setState);

    // timer = Timer.periodic(Duration(seconds: 15), (Timer timer)=>setState );
    var artifacts = Provider.of<Artifacts>(context).artifacts;
    //return Container(child: Text('ssssss'));

    return Container(
        // padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
        child: _buildChild(artifacts));
  }

  Widget _buildChild(List<Artifact> artifacts) {
    if (artifacts.length == 0)
      return Container(child: Text('your album is empty $artifacts.length'));
    else
      return ListView(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
        children: artifacts.map((document) {
          return CustomPost(
            time: document.time,
            message: document.message,
            image: document.image,
            docID: document.docID,
            username: document.username,
            uid: 'seems useless',
          );
        }).toList(),
      );
  }
}
