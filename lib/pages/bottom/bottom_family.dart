import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomFam extends StatefulWidget{
  @override
  _BottomFamState createState() => _BottomFamState();
}

class _BottomFamState extends State<BottomFam>{
  String familyData = "NULL";

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
      if(user == null) {
        familyData = "You are not logged in!";
      }
      else familyData = "Hello " + user.displayName + ", your family list is empty.";
    }).catchError((e) => print(e));
    super.initState();
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(body: Center(child: Container(child: Text(familyData),color: Colors.purple,),),backgroundColor: Colors.pink);
  }
}