import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../../../icons.dart';

class SkCircleBackButton extends StatelessWidget {
  const SkCircleBackButton({
    Key? key,
    required this.onPressed,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  final void Function() onPressed;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SkSemantics(
      identifier: 'back_button',
      excludeSemantics: true,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ?? AegisColors.neutral0,
            shape: BoxShape.circle,
          ),
          child: Icon(
            AegisIcons.chevron_left,
            size: 24,
            color: color ?? AegisColors.iconHighEmphasis,
          ),
        ),
      ),
    );
  }
}
