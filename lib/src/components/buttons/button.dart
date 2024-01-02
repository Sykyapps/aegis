import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../animations/loading_animation.dart';

class SkButton extends HookWidget {
  const SkButton({
    required this.label,
    this.isLoading = false,
    this.loadingColor = AegisColors.neutral100,
    this.bgColor,
    this.textStyle,
    this.onPressed,
    this.elevation = 0,
    super.key,
  });

  final String label;
  final bool isLoading;
  final Color? bgColor;
  final Color loadingColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor ?? AegisColors.purple300,
        disabledBackgroundColor: AegisColors.neutral100,
        disabledForegroundColor: AegisColors.textDisabled,
        textStyle: AegisFont.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
        minimumSize: Size.fromHeight(48.h),
        elevation: elevation,
      ),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? SkLoadingAnimation(color: loadingColor)
          : Text(label, style: textStyle),
    );
  }
}
