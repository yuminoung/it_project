import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BottomMe extends StatefulWidget {
  @override
  _BottomMeState createState() => _BottomMeState();
}

class _BottomMeState extends State<BottomMe> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  String data;

  @override
  void initState() {
    super.initState();
    _auth.currentUser().then((user) {
      if (user != null) {
        setState(() {
          _user = user;
        });
        if(_user.displayName != null){
          data = _user.displayName;
        }
        else data = "the user does not have a name!";
      }
    });
  }

  Future<FirebaseUser> getUserID() async {
    FirebaseUser user = await _auth.currentUser();
    // await Future.delayed(Duration(seconds: 1));
    return user;
  }

  @override
  Widget build(BuildContext context) {
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
                          data,
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
              print("settings");
            },
          ),
          Divider(
            height: 0,
          ),
          ListTile(
            leading: ImageIcon(AssetImage('assets/icons/logout2.png')),
            title: Text('Logout'),
            onTap: () {
              _auth.signOut().then((_) {
                Navigator.pushReplacementNamed(context, '/login');
              }).catchError((error) {
                print("error");
              });
            },
          ),
          Divider(
            height: 0,
          ),
          // RaisedButton(
          //   padding: EdgeInsets.all(16.0),
          //   child: Text('Sign Out'),
          //   onPressed: () {
          //     _auth.signOut().then((result) {
          //       Navigator.pushReplacementNamed(context, '/register');
          //     });
          //   },
          // )
        ],
      ),
    );
  }
}
