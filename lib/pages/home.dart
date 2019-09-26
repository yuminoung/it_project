import 'package:flutter/material.dart';
import 'package:it_project/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:it_project/widgets/custom_bottom_navigation_bar.dart';

import '../widgets/all_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  List<Widget> _tabs = [
    routes['/bottom/home'],
    Container(color: Colors.red),
    Container(color: Colors.green),
    routes['/bottom/me']
  ];

  List<String> _tabTitles = ['Family', 'Space', 'Artifact', 'Me'];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/register');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _tabTitles[_index],
        trailing: _index == 0
            ? CustomIconButton(
                icon: Icon(Icons.camera_alt),
                onTap: () {
                  Navigator.push(
                    context,
                    CustomSlideFromBottomPageRouteBuilder(
                      widget: routes['/upload'],
                    ),
                  );
                },
              )
            : Container(),
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
