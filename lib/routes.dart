import 'pages/home.dart';
import 'pages/upload.dart';

import 'pages/auth/register.dart';
import 'pages/auth/login.dart';

import 'pages/all_pages.dart';

final namedRoutes = {
  '/': (context) => Home(),
  '/upload': (context) => Upload(),
  '/register': (context) => Register(),
  '/login': (context) => Login(),
};

final routes = {
  '/': Home(),
  '/upload': Upload(),
  '/bottom/home': BottomHome(),
  '/bottom/me': BottomMe(),
};
