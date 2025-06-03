import 'package:go_router/go_router.dart';
import 'package:thedailynews/features/splash/presentation/pages/splash_page.dart';

class AppPages {
  static final splashPage = GoRoute(
    path: '/',
    builder: (context, state) => SplashPage(),
  );
}
