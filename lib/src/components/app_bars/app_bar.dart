import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../buttons/back_button.dart';

class SkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SkAppBar({
    super.key,
    this.title = '',
    this.centerTitle = true,
    this.titleTextStyle,
    this.showLeading = true,
    this.leading,
    this.leadingColor,
    this.onLeadingPressed,
    this.actions,
    this.elevation = 0,
    this.systemOverlayStyle,
  });

  final String title;
  final bool centerTitle;
  final TextStyle? titleTextStyle;
  final bool showLeading;
  final Widget? leading;
  final Color? leadingColor;
  final void Function()? onLeadingPressed;
  final List<Widget>? actions;
  final double elevation;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: centerTitle,
      titleTextStyle: titleTextStyle,
      backgroundColor: AegisColors.transparent,
      foregroundColor: AegisColors.textHighEmphasis,
      surfaceTintColor: AegisColors.transparent,
      automaticallyImplyLeading: showLeading,
      leadingWidth: 60.w,
      titleSpacing: 0,
      leading: !showLeading
          ? null
          : leading ??
              SkBackButton(
                color: leadingColor,
                onPressed: onLeadingPressed,
              ),
      actions: actions,
      elevation: elevation,
      systemOverlayStyle: systemOverlayStyle ?? SystemUiOverlayStyle.dark,
    );
  }
}
