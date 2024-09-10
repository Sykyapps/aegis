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
    this.size,
    this.padding,
    this.stretch = true,
    super.key,
  });

  final String label;
  final bool isLoading;
  final bool stretch;
  final Color? bgColor;
  final Color loadingColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? elevation;
  final Size? size;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    var minimumSize = size ?? Size.fromHeight(48.r);

    double? width;
    if (minimumSize.width.isFinite) width = minimumSize.width;
    if (stretch) width = double.infinity;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: minimumSize.height,
        width: width,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AegisColors.neutral0,
          backgroundColor: bgColor ?? AegisColors.purple300,
          disabledBackgroundColor: AegisColors.neutral100,
          disabledForegroundColor: AegisColors.textDisabled,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: AegisFont.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
          elevation: elevation,
          padding: padding,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? SkLoadingAnimation(color: loadingColor)
            : Text(
                label,
                style: textStyle,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  static SkButton small({
    required label,
    bool isLoading = false,
    Color? bgColor,
    Color loadingColor = AegisColors.neutral100,
    TextStyle? textStyle,
    VoidCallback? onPressed,
    double elevation = 0,
    Size? size,
    bool stretch = true,
  }) {
    return SkButton(
      label: label,
      onPressed: onPressed,
      bgColor: bgColor,
      elevation: elevation,
      isLoading: isLoading,
      loadingColor: loadingColor,
      size: size ?? Size.fromHeight(29.r),
      textStyle: textStyle ??
          AegisFont.bodySmall.copyWith(fontWeight: FontWeight.bold),
      padding: EdgeInsets.symmetric(horizontal: 12.r),
      stretch: stretch,
    );
  }
}
