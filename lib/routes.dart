import 'package:it_project/pages/bottom/bottom_family.dart';

import 'pages/all_pages.dart';

final namedRoutes = {
  '/': (context) => Home(),
  '/upload': (context) => Upload(),
  '/register': (context) => Register(),
  '/login': (context) => Login(),
  '/landing': (context) => LandingPage(),
};

final routes = {
  '/': Home(),
  '/upload': Upload(),
  '/bottom/home': BottomHome(),
  '/bottom/me': BottomMe(),
  '/bottom/family':BottomFam(),
  '/settings': Settings(),
};
