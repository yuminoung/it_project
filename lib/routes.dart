import 'package:it_project/pages/family/family_join.dart';
import 'package:it_project/pages/refreshing.dart';

import 'pages/all_pages.dart';

final routes = {
  // auth
  '/login': Login(),
  '/register': Register(),

  // family
  '/family/create': FamilyCreate(),
  '/family/join': FamilyJoin(),

  // bottom
  '/bottom/home': BottomHome(),
  '/bottom/me': BottomMe(),
  '/bottom/family': BottomFamily(),
  '/bottom/notice': BottomNotice(),

  // others
  '/edit': EditPost(),
  '/upload': Upload(),
  '/settings': Settings(),
  '/': Home(),
  '/landing': LandingPage(),
  '/refreshing': RefreshingPage(),
};
