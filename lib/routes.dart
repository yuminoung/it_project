import 'pages/home.dart';
import 'pages/upload.dart';

import 'pages/bottom_navigations/chat.dart';
import 'pages/bottom_navigations/artifact.dart';
import 'pages/bottom_navigations/me.dart';
import 'pages/bottom_navigations/home_bottom.dart';
import 'pages/auth/register.dart';

final namedRoutes = {
  '/': (context) => Home(),
  '/upload': (context) => Upload(),
  '/register': (context) => Register(),
};

final bottomNavRoutes = [
  HomeBottom(),
  Chat(),
  Artifact(),
  Me(),
];
