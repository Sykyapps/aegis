import 'package:flutter/material.dart';

import '../../components/buttons/buttons.dart';

class SkSliverAppBar extends StatelessWidget {
  const SkSliverAppBar({
    Key? key,
    required this.onLeadingPressed,
    required this.title,
    this.isSingleLine = true,
    this.actions,
  }) : super(key: key);

  /// The [onLeadingPressed] will be called when the back button was pressed.
  ///
  /// If this param is null, the back button will be hidden.
  final VoidCallback onLeadingPressed;

  /// The [isSingleLine] determine which variant will be used.
  final bool isSingleLine;

  /// The [title] param will be wrapped by [Text] widget.
  final String title;

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

  @override
  Widget build(BuildContext context) {
    if (!isSingleLine) {
      return SliverAppBar.large(
        pinned: true,
        elevation: 0,
        scrolledUnderElevation: 4,
        leading: SkBackButton(onPressed: onLeadingPressed),
        automaticallyImplyLeading: false,
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        titleSpacing: 0,
        actions: actions,
      );
    }

    return SliverAppBar.medium(
      pinned: true,
      elevation: 0,
      scrolledUnderElevation: 4,
      leading: SkBackButton(onPressed: onLeadingPressed),
      automaticallyImplyLeading: false,
      title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
      titleSpacing: 0,
      actions: actions,
    );
  }
}
