import 'package:go_router/go_router.dart';
import 'package:thedailynews/features/categories/pages/categories_page.dart';
import 'package:thedailynews/features/discover/pages/discover_page.dart';
import 'package:thedailynews/features/home/pages/home_page.dart';
import 'package:thedailynews/features/profile/pages/profile_page.dart';
import 'package:thedailynews/features/splash/pages/splash_page.dart';

class AppPages {
  static final splashPage = GoRoute(
    path: '/',
    builder: (context, state) => SplashPage(),
  );


  static final homePage = GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  );

  static final discoverPage = GoRoute(
    path: '/discover',
    builder: (context, state) => DiscoverPage(),
  );

  static final categoriesPage = GoRoute(
    path: '/categories',
    builder: (context, state) => CategoriesPage(),
  );

  static final profilePage = GoRoute(
    path: '/profile',
    builder: (context, state) => ProfilePage(),
  );
}
