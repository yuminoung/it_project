import 'package:flutter/material.dart';
import 'package:it_project/models/user_model.dart';
import 'package:it_project/pages/bottom/bottom_gallery.dart';
import 'package:it_project/pages/upload.dart';
import 'package:it_project/routes.dart';
import 'package:it_project/widgets/custom_bottom_navigation_bar.dart';

import '../widgets/all_widgets.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int _index = 0;

  List<Widget> _tabs = [
    routes['/bottom/home'],
    routes['/bottom/family'],
    BottomGallery(),
    routes['/bottom/me']
  ];

  List<String> _tabTitles = ['Artifacts', 'Family', 'Gallery', 'Me'];

  Widget _buildAppBarTrailing(int index, BuildContext context) {
    if (index == 0) {
      return CustomIconButton(
        icon: Icon(Icons.camera_alt),
        onTap: () {
          Navigator.push(
              context, CustomSlideFromBottomPageRouteBuilder(widget: Upload()));
          // checkFamAndPop(context);
        },
      );
    } else if (index == 1) {
      return PopupMenuButton(
        onSelected: (value) {
          if (value == 'join') {
            Navigator.push(
              context,
              CustomSlideFromBottomPageRouteBuilder(
                widget: routes['/family/join'],
              ),
            );
          } else if (value == 'create') {
            Navigator.push(
              context,
              CustomSlideFromBottomPageRouteBuilder(
                widget: routes['/family/create'],
              ),
            );
          }
        },
        icon: Icon(Icons.add),
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 'join',
            child: Text('Join'),
          ),
          PopupMenuItem(
            value: 'create',
            child: Text('Create'),
          )
        ],
      );
    }
    return Container();
  }

  // key for registering
  // static final GlobalKey<ScaffoldState> _homestate =
  //     new GlobalKey<ScaffoldState>();

  // adding artifacts message, snake bar display
  // static void artifactAddedMessage() {
  //   _homestate.currentState
  //       .showSnackBar(new SnackBar(content: new Text("Artifact added")));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _homestate,
      appBar: CustomAppBar(
        title: _tabTitles[_index],
        trailing: _buildAppBarTrailing(_index, context),
      ),
      body: _tabs[_index],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          CustomBottomAppBarItem(iconImagePath: 'assets/icons/home.png'),
          CustomBottomAppBarItem(iconImagePath: 'assets/icons/family.png'),
          CustomBottomAppBarItem(iconImagePath: 'assets/icons/photo.png'),
          CustomBottomAppBarItem(iconImagePath: 'assets/icons/face.png'),
        ],
        height: 60,
        selectedColor: Colors.red,
      ),
    );
  }
}

void checkFamAndPop(BuildContext context) async {
  var user = await UserModel.getUserDocument();
  var fam = user.data['families'];
  if (fam.length == 0) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Warning",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              content: Text(
                "Your family list is empty, anything you upload will be visable to yourself only!",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Continue"),
                  color: Colors.green,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CustomSlideFromBottomPageRouteBuilder(
                        widget: routes['/upload'],
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  color: Colors.green,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ]);
        });
  } else {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(
                "Uploading",
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              content: Text(
                "Press the Continue to continue, or cancel uploading",
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Continue"),
                  color: Colors.green,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      CustomSlideFromBottomPageRouteBuilder(
                        widget: routes['/upload'],
                      ),
                    );
                  },
                ),
                FlatButton(
                  child: Text("Cancel"),
                  color: Colors.green,
                  textColor: Colors.black,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ]);
        });
  }
}