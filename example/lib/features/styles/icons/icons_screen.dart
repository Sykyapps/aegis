import 'package:aegis/components.dart';
import 'package:aegis/icons.dart';
import 'package:flutter/material.dart';

import '../../../core/injection/dependency_injection.dart';
import '../../../core/navigation/navigation_service.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    var icons = AegisIcons.all;

    return SkScaffold(
      appBar: SkAppBar(
        title: 'Icons',
        onLeadingPressed: () => ns.pop(),
      ),
      body: ListView.builder(
        itemCount: icons.length,
        itemBuilder: (context, index) {
          var icon = icons.entries.elementAt(index);
          return ListTile(
            title: Text(icon.key),
            trailing: Icon(
              icon.value,
            ),
          );
        },
      ),
    );
  }
}
