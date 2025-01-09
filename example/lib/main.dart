import 'package:aegis/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/injection/dependency_injection.dart';
import 'core/navigation/navigation_service.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.initialize();
  runApp(const AegisApp());
}

class AegisApp extends StatelessWidget {
  const AegisApp({super.key});

  static final _router = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'SayaKaya UI Kit v2',
          themeMode: ThemeMode.dark,
          theme: AegisTheme.lightTheme,
          darkTheme: AegisTheme.darkTheme,
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1)),
              child: child ?? const SizedBox(),
            );
          },
        );
      },
    );
  }
}
