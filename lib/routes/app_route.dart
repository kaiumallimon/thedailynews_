import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:thedailynews/features/wrapper/pages/home_wrapper_page.dart';
import 'package:thedailynews/main.dart';
import 'package:thedailynews/routes/app_pages.dart';

class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: navigatorKey,
    routes: [
      AppPages.splashPage,

      ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => HomeWrapperPage(child: child),
        routes: [
          AppPages.homePage,
          AppPages.discoverPage,
          AppPages.categoriesPage,
          AppPages.profilePage,
        ],
      ),
    ],
  );
}
