import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Me extends StatefulWidget {
  @override
  _MeState createState() => _MeState();
}

class _MeState extends State<Me> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          _user != null ? Text(_user.uid) : Container(),
          RaisedButton(
            child: Text('Sign Out'),
            onPressed: () {
              _auth.signOut().then((result) {
                Navigator.pushReplacementNamed(context, '/register');
              });
            },
          )
        ],
      ),
    );
  }
}
