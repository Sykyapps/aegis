import 'package:get_it/get_it.dart';

import '../navigation/navigation_service.dart';
import '../navigation/router.dart';

final GetIt getIt = GetIt.instance;

class DependencyInjection {
  static void initialize() {
    //* Router -> go_router
    getIt.registerLazySingleton(() => AppRouter());

    //* Navigation Service
    getIt.registerLazySingleton<NavigationService>(
      () => NavigationServiceImpl(router: getIt()),
    );
  }
}
