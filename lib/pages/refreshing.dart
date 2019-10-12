import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';

class RefreshingPage extends StatefulWidget {
  @override
  _RefreshingPageState createState() => _RefreshingPageState();
}

class _RefreshingPageState extends State<RefreshingPage> {
  @override
  void initState() {
    print("Welcome to IT Project!");
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) async {
      await Future.delayed(Duration(seconds: 2));
      Navigator.pushReplacement(context, CustomSlideFromBottomPageRouteBuilder(widget: routes['/bottom_home']),
        );
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Refreshing...",
          style: TextStyle(fontFamily: 'Inconsolata', fontSize: 34, color: Colors.green),
        ),
      ),
    );
  }
}
