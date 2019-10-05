import 'package:flutter/material.dart';
import 'package:it_project/providers/artifacts.dart';
import 'package:it_project/routes.dart';
import 'package:it_project/widgets/custom_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/all_widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  List<Widget> _tabs = [
    routes['/bottom/home'],
    routes['/bottom/family'],
    Container(color: Colors.green),
    routes['/bottom/me']
  ];

  List<String> _tabTitles = ['Artifacts', 'Family', 'Notifications', 'Me'];

  Widget _buildAppBarTrailing(int index) {
    if (index == 0) {
      return CustomIconButton(
        icon: Icon(Icons.camera_alt),
        onTap: () {
          Navigator.push(
            context,
            CustomSlideFromBottomPageRouteBuilder(
              widget: routes['/upload'],
            ),
          );
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

  @override
  Widget build(BuildContext context) {
    print('home build');

    Provider.of<Artifacts>(context, listen: false).fetchAndSetArtifacts();
    return Scaffold(
      appBar: CustomAppBar(
        title: _tabTitles[_index],
        trailing: _buildAppBarTrailing(_index),
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
