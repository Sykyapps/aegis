import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkButton extends HookWidget {
  const SkButton({
    required this.label,
    this.child,
    this.bgColor,
    this.textStyle,
    this.onPressed,
    super.key,
  });

  final String label;
  final Widget? child;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AegisColors.purple300,
        textStyle: AegisFont.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
        minimumSize: Size.fromHeight(48.h),
      ),
      onPressed: onPressed,
      child: child ?? Text(label, style: textStyle),
    );
  }
}
