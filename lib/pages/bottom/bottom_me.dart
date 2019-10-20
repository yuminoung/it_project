import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_project/pages/all_pages.dart';
import 'package:it_project/providers/auth.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';
import 'package:it_project/models/all_models.dart';
import 'package:provider/provider.dart';

class BottomMe extends StatefulWidget {
  @override
  _BottomMeState createState() => _BottomMeState();
}

class _BottomMeState extends State<BottomMe> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String profile;
  String displayName;
  @override
  void initState() {
    super.initState();
    displayName = Provider.of<Auth>(context, listen: false).displayName;

    // _auth.currentUser().then((user) {
    //   if (user != null) {
    //     setState(() {
    //       _user = user;
    //     });
    //     if (_user.displayName != null) {
    //       profile = _user.displayName;
    //     } else
    //       profile = "the user does not have a name!";
    //   } else
    //     profile = "You are not logged in yet!";
    // });
  }

  Future<FirebaseUser> getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    // await Future.delayed(Duration(seconds: 1));
    return user;
  }

  @override
  Widget build(BuildContext context) {
    print('bottom me  rebuilt, display name is $displayName');
    return Container(
      padding: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          FutureBuilder(
            future: getUserID(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/profile.png'),
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          displayName == null ? 'no display' : displayName,
                          // snapshot.data.uid,
                          style: TextStyle(fontSize: 18),
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: ImageIcon(AssetImage('assets/icons/setting.png')),
            title: Text('Settings'),
            onTap: () {
              print('ok');
              Navigator.push(
                  context,
                  CustomSlideFromBottomPageRouteBuilder(
                      widget: routes['/settings']));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: ImageIcon(AssetImage('assets/icons/face.png')),
            title: Text('Profile'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UploadProfile();
              }));
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: ImageIcon(AssetImage('assets/icons/logout2.png')),
            title: Text('Logout'),
            onTap: () async {
              UserModel.cleanUserModel();
              _auth.signOut().then((_) {
                Navigator.pushReplacement(
                    context,
                    CustomSlideFromBottomPageRouteBuilder(
                        widget: routes['/login']));
              }).catchError((error) {
                print("error");
              });
            },
          ),
          Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
