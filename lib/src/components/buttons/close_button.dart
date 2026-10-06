import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';

class SkCloseButton extends StatelessWidget {
  const SkCloseButton({
    super.key,
    this.color,
    this.onPressed,
  });

  final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SkSemantics(
      identifier: 'back_button',
      excludeSemantics: true,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(
          AegisIcons.close,
          size: 24,
          color: color ?? AegisColors.iconHighEmphasis,
        ),
      ),
    );
  }
}
