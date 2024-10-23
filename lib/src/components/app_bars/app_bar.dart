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
    this.titleSpacing = 0,
    this.bottom,
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
  final double titleSpacing;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

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
      titleSpacing: titleSpacing,
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
      bottom: bottom,
    );
  }
}
