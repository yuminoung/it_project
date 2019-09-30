import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) async {
      await Future.delayed(Duration(seconds: 2));
      if (user == null) {
        Navigator.pushReplacement(
          context,
          CustomSlideFromBottomPageRouteBuilder(widget: routes['/login']),
        );
      } else {
        Navigator.pushReplacement(
          context,
          CustomSlideFromBottomPageRouteBuilder(widget: routes['/']),
        );
      }
    }).catchError((e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "IT PROJECT\nHELLO WOLRD\n😆 OLIVER\n🤨 HAITIAN\n😋 YUMIN\n😎 ZIRUN",
          style: TextStyle(fontFamily: 'Inconsolata', fontSize: 34),
        ),
      ),
    );
  }
}
