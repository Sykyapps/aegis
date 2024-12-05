import 'package:aegis/components.dart';
import 'package:flutter/material.dart';

import '../../core/injection/dependency_injection.dart';
import '../../core/navigation/navigation_service.dart';

class StylesScreen extends StatelessWidget {
  const StylesScreen({super.key});

  static final NavigationService nav = getIt();

  @override
  Widget build(BuildContext context) {
    return SkScaffold(
      appBar: SkAppBar(
        title: 'Styles',
        onLeadingPressed: () => nav.pop(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Icons'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.icons.path),
          ),
        ],
      ),
    );
  }
}
