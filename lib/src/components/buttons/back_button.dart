import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../../../icons.dart';

class SkBackButton extends StatelessWidget {
  const SkBackButton({Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      icon: Icon(
        AegisIcons.chevron_left,
        size: 22.r,
        color: AegisColors.iconHighEmphasis,
      ),
    );
  }
}
