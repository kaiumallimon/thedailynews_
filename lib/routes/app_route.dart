import 'package:go_router/go_router.dart';
import 'package:thedailynews/main.dart';
import 'package:thedailynews/routes/app_pages.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    routes: [AppPages.splashPage],
  );
}
