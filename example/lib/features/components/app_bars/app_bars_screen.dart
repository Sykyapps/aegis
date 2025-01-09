import 'package:aegis/components.dart';
import 'package:flutter/material.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../../core/navigation/navigation_service.dart';

class AppBarsScreen extends StatelessWidget {
  const AppBarsScreen({super.key});

  static final NavigationService nav = getIt();

  @override
  Widget build(BuildContext context) {
    return SkScaffold(
      appBar: SkAppBar(
        title: 'App Bars',
        onLeadingPressed: () => nav.pop(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Basic App Bar'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.basicAppBar.path),
          ),
          ListTile(
            title: const Text('Sliver App Bar'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.sliverAppBar.path),
          ),
        ],
      ),
    );
  }
}
