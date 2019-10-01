import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:it_project/widgets/custom_progress_indicator.dart';
import 'package:it_project/models/all_models.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/pages/all_pages.dart';

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
    return Container(
      padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: UserModel.getUserDocument(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data['families'] != null) {
            Map<String, String> families =
                snapshot.data['families'].cast<String, String>();

            return ListView(
              children: families.keys.map((key) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(families[key]),
                      onTap: () {
                        Navigator.push(
                            context,
                            CustomSlideFromBottomPageRouteBuilder(
                                widget: FamilyView(
                              familyID: key,
                              familyName: families[key],
                            )));
                      },
                    ),
                    Divider(),
                  ],
                );
              }).toList(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return CustomProgressIndicator();
          }
          return Center(
            child: Text(
              'You don\'t have a family',
              style: TextStyle(fontSize: 24, fontFamily: 'Inconsolata'),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
