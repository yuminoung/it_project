import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String image;
  final String title;
  final Timestamp time;
  final String docID;
  Post({this.image, this.title, this.time,this.docID});

  String humanReadableTime(Timestamp time) {
    // int day = time.toDate().day;
    // int hour = time.toDate().hour;
    // int min = time.toDate().minute;
    // int second = time.toDate().second;

    return time.toDate().toString();
  }
  

  @override
  Widget build(BuildContext context) {
    StorageReference ref = FirebaseStorage.instance.ref().child('images/'+ docID);
    if (image != null) {
      return Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    child: Padding(
                      child: Icon(Icons.person),
                      padding: EdgeInsets.all(8.0),
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Yumin'),
                    ),
                    alignment: Alignment.center,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(humanReadableTime(time),
                          style: TextStyle(color: Colors.pink, fontSize: 10)),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.all(8.0),
                        alignment: Alignment.centerRight,
                        child: PopupMenuButton(
                          child: Icon(Icons.more_horiz),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text('edit'),
                            ),
                            PopupMenuItem(
                              child: GestureDetector( 
                                onTap: (){
                                  Firestore.instance.document('message/' + docID).delete();
                                  ref.delete();
                                },
                                child: Text('delete'),
                                ),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.network(
                image,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}
