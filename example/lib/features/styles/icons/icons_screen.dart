import 'package:aegis/icons.dart';
import 'package:flutter/material.dart';

class IconsScreen extends StatelessWidget {
  const IconsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var icons = AegisIcons.all;

    return Scaffold(
      appBar: AppBar(title: const Text('Icons')),
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
