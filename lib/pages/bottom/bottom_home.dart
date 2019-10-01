import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/widgets/custom_progress_indicator.dart';

class BottomHome extends StatefulWidget {
  @override
  _BottomHomeState createState() => _BottomHomeState();
}

class _BottomHomeState extends State<BottomHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('artifacts')
            // .where('user', isEqualTo: 'Yumin')
            .orderBy('created_at', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return CustomProgressIndicator();
            default:
              return ListView(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return CustomPost(
                    time: document['created_at'],
                    message: document['message'],
                    image: document['image'],
                    docID: document.documentID,
                    username: document['user'],
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
