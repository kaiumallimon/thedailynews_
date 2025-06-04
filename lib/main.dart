import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thedailynews/features/wrapper/presentation/bloc/navigation_bloc.dart';
import 'package:thedailynews/routes/app_route.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => NavigationBloc())],
      child: MaterialApp.router(
        routerDelegate: AppRoute.router.routerDelegate,
        routeInformationParser: AppRoute.router.routeInformationParser,
        routeInformationProvider: AppRoute.router.routeInformationProvider,
      ),
    );
  }
}
