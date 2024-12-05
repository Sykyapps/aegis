import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/components/buttons/buttons_screen.dart';
import '../../features/components/components_screen.dart';
import '../../features/components/fields/fields_screen.dart';
import '../../features/components/tabs/tabs_screen.dart';
import '../../features/components/sheets/sheets_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/styles/icons/icons_screen.dart';
import '../../features/styles/styles_screen.dart';
import 'screens.dart';

class AppRouter extends GoRouter {
  static final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  AppRouter()
      : super(
          initialLocation: AegisScreens.home.path,
          navigatorKey: _navigatorKey,
          routes: [
            GoRoute(
              name: AegisScreens.home.name,
              path: AegisScreens.home.path,
              builder: (_, __) => const HomeScreen(),
            ),
            GoRoute(
              name: AegisScreens.styles.name,
              path: AegisScreens.styles.path,
              builder: (_, __) => const StylesScreen(),
            ),
            GoRoute(
              name: AegisScreens.icons.name,
              path: AegisScreens.icons.path,
              builder: (_, __) => const IconsScreen(),
            ),
            GoRoute(
              name: AegisScreens.components.name,
              path: AegisScreens.components.path,
              builder: (_, __) => const ComponentsScreen(),
            ),
            GoRoute(
              name: AegisScreens.sheets.name,
              path: AegisScreens.sheets.path,
              builder: (_, __) => const SheetsScreen(),
            ),
            GoRoute(
              name: AegisScreens.tabs.name,
              path: AegisScreens.tabs.path,
              builder: (_, __) => const TabsScreen(),
            ),
            GoRoute(
              name: AegisScreens.fields.name,
              path: AegisScreens.fields.path,
              builder: (_, __) => const FieldsScreen(),
            ),
            GoRoute(
              name: AegisScreens.buttons.name,
              path: AegisScreens.buttons.path,
              builder: (_, __) => const ButtonsScreen(),
            ),
          ],
          errorBuilder: (_, state) =>
              Scaffold(body: Center(child: Text('Error : ${state.error}'))),
        );
}
