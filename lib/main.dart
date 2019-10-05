import 'package:flutter/material.dart';
import 'package:it_project/pages/edit_post.dart';
import 'package:it_project/providers/artifacts.dart';

import 'routes.dart';
import 'theme.dart';
import 'package:provider/provider.dart';
import 'package:it_project/providers/auth.dart';
// Am I in the new branch?

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: (Auth()),
          ),
          ChangeNotifierProxyProvider<Auth, Artifacts>(
            builder: (ctx, auth, previousOrders) => Artifacts(auth.userId),
          )
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  theme: themeData,
                  debugShowCheckedModeBanner: false,
                  home: routes['/landing'],
                  routes: {
                    EditPost.routeName: (ctx) => EditPost(),
                    // '/upload': (ctx) => Upload()
                  },
                )));
  }
}
