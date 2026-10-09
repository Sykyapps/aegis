import 'package:flutter/material.dart';

import '../../../foundation.dart';

class SkScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Color backgroundColor;
  final Widget? bottomNavigationBar;
  final bool extendBodyBehindAppBar;
  final bool extendBody;
  final Widget? floatingActionButton;
  final List<Widget>? persistentFooterButtons;
  final bool? resizeToAvoidBottomInset;

  const SkScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.backgroundColor = AegisColors.neutral0,
    this.bottomNavigationBar,
    this.extendBodyBehindAppBar = false,
    this.extendBody = false,
    this.persistentFooterButtons,
    this.resizeToAvoidBottomInset,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Theme(
        data: Theme.of(context),
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: appBar,
          body: body,
          persistentFooterButtons: persistentFooterButtons,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          extendBody: extendBody,
          bottomNavigationBar: bottomNavigationBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
