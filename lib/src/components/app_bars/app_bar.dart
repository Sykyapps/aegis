import 'package:flutter/material.dart';

import '../../../foundation.dart';
import '../buttons/back_button.dart';

class SkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SkAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.titleTextStyle,
    this.showLeading = true,
    this.leading,
    this.onLeadingPressed,
    this.actions,
    this.elevation = 0,
  });

  final String title;
  final bool centerTitle;
  final TextStyle? titleTextStyle;
  final bool showLeading;
  final Widget? leading;
  final void Function()? onLeadingPressed;
  final List<Widget>? actions;
  final double elevation;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
      backgroundColor: AegisColors.neutral0,
      foregroundColor: AegisColors.textHighEmphasis,
      automaticallyImplyLeading: showLeading,
      leading: !showLeading
          ? null
          : leading ?? SkBackButton(onPressed: onLeadingPressed),
      actions: actions,
      elevation: elevation,
    );
  }
}
