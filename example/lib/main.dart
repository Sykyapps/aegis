import 'package:aegis_app/core/injection/dependency_injection.dart';
import 'package:aegis_app/core/navigation/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.initialize();
  runApp(const AegisApp());
}

class AegisApp extends StatelessWidget {
  const AegisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 780),
      builder: (context, child) {
        var router = getIt<AppRouter>().router;
        return MaterialApp.router(
          title: 'Aegis App',
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: child ?? const SizedBox(),
            );
          },
        );
      },
    );
  }
}
