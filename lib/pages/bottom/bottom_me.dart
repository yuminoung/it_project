import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_project/widgets/all_widgets.dart';
import 'package:it_project/routes.dart';
import 'package:it_project/models/all_models.dart';

class BottomMe extends StatefulWidget {
  @override
  _BottomMeState createState() => _BottomMeState();
}

class _BottomMeState extends State<BottomMe> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  String profile;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
        if (_user.displayName != null) {
          profile = _user.displayName;
        } else
          profile = "the user does not have a name!";
      } else
        profile = "You are not logged in yet!";
    });
  }

  Future<FirebaseUser> getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    // await Future.delayed(Duration(seconds: 1));
    return user;
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text("Logged out"),
                ),
                Divider(
                  color: Colors.grey,
                  height: 0,
                ),
                FlatButton(
                  child: Text("Log in"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
                Divider(
                  color: Colors.grey,
                  height: 0,
                ),
                FlatButton(
                  child: Text("Register"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
                Divider(
                  color: Colors.grey,
                  height: 0,
                ),
              ],
            ),
          ));
    }

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
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/profile.png'),
                          width: MediaQuery.of(context).size.width / 6,
                          height: MediaQuery.of(context).size.width / 6,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Text(
                          profile,
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
