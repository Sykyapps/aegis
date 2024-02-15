import 'package:flutter/material.dart';

import '../../../foundation.dart';

class SkScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final List<Widget>? persistentFooterButtons;
  final bool? resizeToAvoidBottomInset;

  const SkScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.backgroundColor = AegisColors.neutral0,
    this.bottomNavigationBar,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Theme(
        data: ThemeData(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: body,
          persistentFooterButtons: persistentFooterButtons,
          bottomNavigationBar: bottomNavigationBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        ),
      ),
    );
  }
}
