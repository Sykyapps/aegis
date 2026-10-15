import 'package:flutter/widgets.dart';

/// Pads [child] above the keyboard.
///
/// Reads the keyboard inset in its own small widget, so a keyboard animation
/// only rebuilds this padding each frame instead of the whole screen or
/// sheet. This matters for routes that stay mounted under other routes: they
/// still rebuild when a keyboard opens on a route above them.
class SkKeyboardInsetPadding extends StatelessWidget {
  const SkKeyboardInsetPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: child,
    );
  }
}
