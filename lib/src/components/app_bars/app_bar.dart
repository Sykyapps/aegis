import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../buttons/back_button.dart';

class SkAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SkAppBar({
    super.key,
    this.onLeadingPressed,
    this.title = '',
    this.titleWidget,
    this.centerTitle,
    this.actions,
    this.bottom,
    this.elevation = 0,
    this.systemOverlayStyle,
  });

  /// The [onLeadingPressed] will be called when the back button was pressed.
  ///
  /// If this param is null, the back button will be hidden.
  final VoidCallback? onLeadingPressed;

  /// The [title] param will be wrapped by [Text] widget.
  final String title;

  /// The [titleWidget] param will be prioritized than the [title] param.
  final Widget? titleWidget;

  /// The [centerTitle] param can be used to override the title position.
  final bool? centerTitle;

  /// A list of Widgets to display in a row after the [title] widget.
  ///
  /// Typically these widgets are [IconButton]s representing common operations.
  /// For less common operations, consider using a [PopupMenuButton] as the last
  /// action.
  ///
  /// The [actions] become the trailing component of the [NavigationToolbar]
  /// built by this widget. The height of each action is constrained to be no
  /// bigger than the [toolbarHeight].
  final List<Widget>? actions;

  /// This widget appears across the bottom of the app bar.
  ///
  /// Typically a [TabBar] or a [SearchField].
  final PreferredSizeWidget? bottom;

  /// The [elevation] will override the [elevation] of the [AppBarTheme].
  final double elevation;

  /// The [systemOverlayStyle] will override the [systemOverlayStyle] of the
  /// [AppBarTheme].
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: onLeadingPressed == null
          ? null
          : SkBackButton(onPressed: onLeadingPressed),
      title: titleWidget ?? Text(title),
      titleSpacing: onLeadingPressed == null ? null : 0,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      actions: actions,
      bottom: bottom,
      elevation: elevation,
      systemOverlayStyle: systemOverlayStyle,
    );
  }
}
