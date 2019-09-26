import 'pages/all_pages.dart';

final namedRoutes = {
  '/': (context) => Home(),
  '/upload': (context) => Upload(),
  '/register': (context) => Register(),
  '/login': (context) => Login(),
  '/edit': (context) => EditPost(),
};

final routes = {
  '/': Home(),
  '/upload': Upload(),
  '/bottom/home': BottomHome(),
  '/bottom/me': BottomMe(),
};
