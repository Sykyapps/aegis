import 'package:aegis_app/core/injection/dependency_injection.dart';
import 'package:aegis_app/core/navigation/navigation_service.dart';
import 'package:aegis_app/core/navigation/screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final NavigationService ns = getIt();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AegisScreen.home.title),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(AegisScreen.bottomsheet.title),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              /// Go to [BottomSheetScreen]
              ns.push(AegisScreen.bottomsheet.path);
            },
          ),
          ListTile(
            title: Text(AegisScreen.segmentedControl.title),
            trailing: const Icon(Icons.arrow_right_rounded),
            onTap: () {
              /// Go to [SegmentedControlScreen]
              ns.push(AegisScreen.segmentedControl.path);
            },
          ),
        ],
      ),
    );
  }
}
