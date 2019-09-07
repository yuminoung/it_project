import 'pages/home.dart';
import 'pages/timeline.dart';
import 'pages/upload.dart';

import 'pages/bottom_navigations/chat.dart';
import 'pages/bottom_navigations/artifact.dart';
import 'pages/bottom_navigations/me.dart';
import 'pages/bottom_navigations/home_bottom.dart';

final namedRoutes = {
  '/': (context) => Home(),
  '/timeline': (context) => Timeline(),
  '/upload': (context) => Upload(),
};

final bottomNavRoutes = [
  HomeBottom(),
  Chat(),
  Artifact(),
  Me(),
];
