import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('message')
            .where('user', isEqualTo: 'Yumin')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(document['message']),
                          subtitle: Text(document['date'].toDate().toString()),
                        ),
                        document['image'] != null
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  document['image'],
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : Text('no image')
                      ],
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        // mini: true,
        onPressed: () {
          Navigator.pushNamed(context, '/upload');
        },
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Artifacts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('Me'),
          ),
        ],
      ),
    );
  }
}
