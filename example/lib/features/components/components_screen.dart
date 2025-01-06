import 'package:aegis/components.dart';
import 'package:flutter/material.dart';

import '../../core/injection/dependency_injection.dart';
import '../../core/navigation/navigation_service.dart';

class ComponentsScreen extends StatelessWidget {
  const ComponentsScreen({super.key});

  static final NavigationService nav = getIt();

  @override
  Widget build(BuildContext context) {
    return SkScaffold(
      appBar: SkAppBar(
        title: 'Components',
        onLeadingPressed: () => nav.pop(),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('App Bars'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.appBars.path),
          ),
          ListTile(
            title: const Text('Buttons'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.buttons.path),
          ),
          ListTile(
            title: const Text('Fields'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.fields.path),
          ),
          ListTile(
            title: const Text('Sheets'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.sheets.path),
          ),
          ListTile(
            title: const Text('Tabs'),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () => nav.push(AegisScreens.tabs.path),
          ),
        ],
      ),
    );
  }
}
