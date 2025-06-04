import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedailynews/features/categories/providers/news_category_provider.dart';
import 'package:thedailynews/features/home/providers/home_provider.dart';
import 'package:thedailynews/routes/app_route.dart';
import 'package:thedailynews/features/wrapper/Provider/navigation_provider.dart';
import 'injection_container.dart' as di;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<NavigationProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
        ChangeNotifierProvider(create: (_)=>di.sl<NewsCategoryProvider>()),
      ],
      child: MaterialApp.router(
        routerDelegate: AppRoute.router.routerDelegate,
        routeInformationParser: AppRoute.router.routeInformationParser,
        routeInformationProvider: AppRoute.router.routeInformationProvider,
      ),
    );
  }
}
