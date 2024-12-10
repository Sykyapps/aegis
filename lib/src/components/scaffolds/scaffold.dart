import 'package:flutter/material.dart';

import '../../../components.dart';

class SkScaffold extends StatelessWidget {
  /// The primary content of the scaffold.
  final Widget body;

  /// Please use [SkAppBar] to maintain a consistent app bar
  final SkAppBar? appBar;

  /// This can be used for bottom actions (e.g., BottomNavigationBar, Button)
  final Widget? bottomNavigationBar;

  const SkScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
