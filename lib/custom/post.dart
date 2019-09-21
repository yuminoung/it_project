import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String image;
  final String title;
  final Timestamp time;
  DocumentReference doc;
  Post({this.image, this.title, this.time});

  String humanReadableTime(Timestamp time) {
    // int day = time.toDate().day;
    // int hour = time.toDate().hour;
    // int min = time.toDate().minute;
    // int second = time.toDate().second;

    return time.toDate().toString();
  }
  
  void postCommand (var value){
    if(value == 1) {
      doc.delete();
    }
    else {
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              value: 0
                            ),
                            PopupMenuItem(
                              child: Text('delete'),
                              value: 1
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
