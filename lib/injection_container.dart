import 'package:get_it/get_it.dart';
import 'package:thedailynews/data/services/category_services.dart';
import 'package:thedailynews/features/home/providers/home_provider.dart';
import 'package:thedailynews/features/wrapper/Provider/navigation_provider.dart';
import 'package:thedailynews/core/network/dio_client.dart';
import 'package:thedailynews/data/services/breaking_news_service.dart';
import 'package:thedailynews/features/categories/providers/news_category_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  sl.registerLazySingleton(() => DioClient());

  // Services
  sl.registerLazySingleton(() => BreakingNewsService(sl()));

  // Providers
  sl.registerFactory(() => HomeProvider(sl()));

  // Navigation Provider
  sl.registerLazySingleton(() => NavigationProvider());

  // Category services
  sl.registerLazySingleton(() => CategoryServices(sl()));

  // Category Provider
  sl.registerFactory(() => NewsCategoryProvider(sl()));
}
