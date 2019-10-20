import 'package:flutter/material.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/models/all_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomHome extends StatefulWidget {
  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  String uid;

  @override
  @override
  void initState() {
    super.initState();
    UserModel.getUser().then((user) {
      uid = user.uid;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return uid == null
        ? Container()
        : Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: ArtifactModel.fetchArtifacts(uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return CustomProgressIndicator();
                  default:
                    return ListView(
                      padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return CustomPost(
                          time: document['created_at'],
                          message: document['message'],
                          image: document['image'],
                          docID: document.documentID,
                          username: document['user'],
                          uid: document['uid'],
                          profileURL: document['profile_url'],
                        );
                      }).toList(),
                    );
                }
              },
            ),
          );
  }
}
