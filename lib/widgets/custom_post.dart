import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:it_project/widgets/all_widgets.dart';

class CustomPost extends StatelessWidget {
  final String image;
  final String message;
  final Timestamp time;
  final String docID;
  CustomPost({this.image, this.message, this.time, this.docID});

  Widget _buildImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(4),
        bottomRight: Radius.circular(4),
      ),
      child: Image.network(
        image,
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Widget _buildUser() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            child: Image.asset(
              'assets/images/profile.png',
              height: 50,
              width: 50,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Yuminoung',
              // style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            child:
                Text(_humanReadableTime(time), style: TextStyle(fontSize: 10)),
          ),
          Expanded(
            child: Container(
              child: PopupMenuButton(
                child: Icon(Icons.more_horiz),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text('edit'),
                  ),
                  PopupMenuItem(
                    child: GestureDetector(
                      onTap: () {
                        print(docID);
                        Firestore.instance.document('artifacts/' + docID).delete();
                        StorageReference ref = FirebaseStorage.instance.ref().child('images/'+ docID);
                        ref.delete();
                        Navigator.pop(context);
                      },
                      child: Text('delete'),
                    ),
                  )
                ],
              ),
              alignment: Alignment.centerRight,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessage() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        message,
        style: TextStyle(fontFamily: 'Roboto'),
        // textAlign: TextAlign.left,
      ),
      padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
    );
  }

  String _humanReadableTime(Timestamp time) {
    int dayDiff = DateTime.now().difference(time.toDate()).inDays;
    int hourDiff = DateTime.now().difference(time.toDate()).inHours;
    int minuteDiff = DateTime.now().difference(time.toDate()).inMinutes;

    if (dayDiff > 0) {
      String ago = dayDiff > 1 ? " days ago" : " day ago";
      return dayDiff.toString() + ago;
    }
    if (hourDiff > 0) {
      String ago = hourDiff > 1 ? " hours ago" : " hour ago";
      return hourDiff.toString() + ago;
    }
    if (minuteDiff > 0) {
      String ago = minuteDiff > 1 ? " minutes ago" : " minute ago";
      return minuteDiff.toString() + ago;
    }
    return "Just now";
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _buildUser(),
            (message != null) ? _buildMessage() : Container(),
            (image != null) ? _buildImage(context) : Container(),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}
