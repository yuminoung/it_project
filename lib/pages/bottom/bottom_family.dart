import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomFamily extends StatefulWidget {
  @override
  _BottomFamilyState createState() => _BottomFamilyState();
}

class _BottomFamilyState extends State<BottomFamily> {
  String familyData = "NULL";

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        setState(() {
          familyData = "You are not logged in!";
        });
      } else {
        setState(() {
          familyData =
              "Hello " + user.displayName + ", your family list is empty.";
        });
      }
    }).catchError((e) => print(e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
