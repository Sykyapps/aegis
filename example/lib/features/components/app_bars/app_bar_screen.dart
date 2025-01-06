import 'dart:core';

import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../../core/navigation/navigation_service.dart';

class AppBarScreen extends HookWidget {
  const AppBarScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    var controller = useTabController(initialLength: 2);

    return SkScaffold(
      appBar: SkAppBar(
        title: 'Basic App Bar',
        onLeadingPressed: () => ns.pop(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: const [
            Tab(height: 35, child: Text('Left')),
            Tab(height: 35, child: Text('Right')),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Placeholder(fallbackHeight: 1000),
      ),
    );
  }
}
