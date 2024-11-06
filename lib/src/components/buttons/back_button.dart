import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../../../icons.dart';

class SkBackButton extends StatelessWidget {
  const SkBackButton({Key? key, this.color, this.onPressed}) : super(key: key);

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
          AegisIcons.chevron_left,
          size: 22.r,
          color: color ?? AegisColors.iconHighEmphasis,
        ),
      ),
    );
  }
}
