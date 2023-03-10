import 'package:aegis_app/core/navigation/screens.dart';
import 'package:aegis_app/features/segmented_control/segmented_control_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/bottomsheet/bottomsheet_screen.dart';
import '../../features/home/home_screen.dart';

class AppRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => _router;
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static final _router = GoRouter(
    initialLocation: AegisScreen.home.path,
    navigatorKey: _navigatorKey,
    routes: <GoRoute>[
      GoRoute(
        name: AegisScreen.home.name,
        path: AegisScreen.home.path,
        builder: (context, state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        name: AegisScreen.bottomsheet.name,
        path: AegisScreen.bottomsheet.path,
        builder: (context, state) {
          return const BottomSheetScreen();
        },
      ),
      GoRoute(
        name: AegisScreen.segmentedControl.name,
        path: AegisScreen.segmentedControl.path,
        builder: (context, state) {
          return const SegmentedControlScreen();
        },
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Text('Error : ${state.error}'),
        ),
      );
    },
  );
}
