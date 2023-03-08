import 'package:aegis/src/components/animations/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkButton extends HookWidget {
  const SkButton({
    required this.label,
    this.loadingSize = 40,
    this.isLoading = false,
    this.bgColor,
    this.textStyle,
    this.onPressed,
    this.elevation,
    super.key,
  });

  final String label;
  final double loadingSize;
  final bool isLoading;
  final Color? bgColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: bgColor ?? AegisColors.purple300,
        textStyle: AegisFont.bodyLarge.copyWith(
          fontWeight: FontWeight.bold,
        ),
        minimumSize: Size.fromHeight(48.h),
        elevation: elevation,
      ),
      onPressed: isLoading ? () {} : onPressed,
      child: isLoading
          ? SkLoadingAnimation(size: loadingSize)
          : Text(label, style: textStyle),
    );
  }
}
