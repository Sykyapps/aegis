import 'package:aegis_app/core/navigation/navigation_service.dart';
import 'package:aegis_app/core/navigation/router.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static void initialize() {
    //* Router -> go_router
    getIt.registerLazySingleton<AppRouter>(() => AppRouter());

    //* Navigation Service
    getIt.registerLazySingleton<NavigationService>(
      () => NavigationService(router: getIt()),
    );
  }
}
