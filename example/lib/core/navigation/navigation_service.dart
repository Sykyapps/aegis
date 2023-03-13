import 'package:aegis_app/core/navigation/router.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final AppRouter router;

  NavigationService({required this.router});

  void push(String path) => router.router.push(path);
  void pushNamed(String name) => router.router.pushNamed(name);
  void pop() => router.router.pop();
  bool canPop() => router.router.canPop();
  BuildContext? get currentContext => router.navigatorKey.currentContext;
}
