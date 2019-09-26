import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user){
      if(user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      else Navigator.pushReplacementNamed(context, '/');
    }).catchError((e) => print(e));
    super.initState();
  }
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Center(child: Text("Hello World is loading for you..."),),
      backgroundColor: Colors.green,
    );
  }
}