import 'package:flutter/material.dart';

import 'router.dart';

export 'screens.dart';

abstract class NavigationService<T> {
  RouterDelegate<Object>? get routerDelegate;

  RouteInformationParser<Object>? get routeInformationParser;

  BuildContext? get currentContext;

  void push(T destination);

  void pushNamed(String name);

  void pop();

  bool canPop();
}

class NavigationServiceImpl extends NavigationService<String> {
  final AppRouter router;

  NavigationServiceImpl({required this.router});

  @override
  RouteInformationParser<Object>? get routeInformationParser =>
      router.routeInformationParser;

  @override
  RouterDelegate<Object>? get routerDelegate => router.routerDelegate;

  @override
  BuildContext? get currentContext => router.navigatorKey.currentContext;

  @override
  bool canPop() => router.canPop();

  @override
  void pop() => router.pop();

  @override
  void push(String destination) => router.push(destination);

  @override
  void pushNamed(String name) => router.pushNamed(name);
}
