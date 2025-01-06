import 'package:aegis/components.dart';
import 'package:flutter/material.dart';

import '../../core/injection/dependency_injection.dart';
import '../../core/navigation/navigation_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    return SkScaffold(
      appBar: const SkAppBar(title: 'Home'),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Styles'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => ns.push(AegisScreens.styles.path),
          ),
          ListTile(
            title: const Text('Components'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => ns.push(AegisScreens.components.path),
          ),
        ],
      ),
    );
  }
}
