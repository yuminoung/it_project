import 'package:flutter/material.dart';
import 'package:it_project/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
      appBar: AppBar(
        title: Text('Hello'),
      ),
      body: bottomNavRoutes[_currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/upload');
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            title: Text('Chat'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Artifacts'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            title: Text('Me'),
          ),
        ],
      ),
    );
  }
}
