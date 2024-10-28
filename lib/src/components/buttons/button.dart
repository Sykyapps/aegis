import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkButton extends HookWidget {
  const SkButton({
    required this.label,
    this.isLoading = false,
    this.foregroundColor,
    this.backgroundColor,
    this.textStyle,
    this.onPressed,
    this.elevation = 0,
    this.customSize,
    this.size = SkButtonSize.regular,
    this.padding,
    this.stretch = true,
    super.key,
  }) : assert(size != SkButtonSize.custom || customSize != null,
            'If size is SkButtonSize.custom, customSize must be provided.');

  final String label;
  final bool isLoading;
  final bool stretch;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? elevation;
  final SkButtonSize size;
  final Size? customSize;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    TextStyle style = switch (size) {
      SkButtonSize.small => AegisFont.bodySmall,
      SkButtonSize.medium => AegisFont.bodyMedium,
      SkButtonSize.regular => AegisFont.bodyLarge,
      _ => AegisFont.bodyMedium,
    }
        .merge(textStyle)
        .copyWith(fontWeight: FontWeight.bold);

    Size minimumSize = switch (size) {
      SkButtonSize.small => Size.fromHeight(29.r),
      SkButtonSize.medium => Size.fromHeight(36.r),
      SkButtonSize.regular => Size.fromHeight(48.r),
      _ => customSize!,
    };

    double? width;

    double paddingValue = switch (size) {
      SkButtonSize.small => 12,
      SkButtonSize.medium => 16,
      SkButtonSize.regular => 20,
      _ => 16,
    }
        .r;

    if (minimumSize.width.isFinite) width = minimumSize.width;
    if (stretch) width = 1.sw;

    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        height: minimumSize.height,
        width: width,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor:
              foregroundColor ?? style.color ?? AegisColors.neutral0,
          backgroundColor: backgroundColor ?? AegisColors.purple300,
          disabledBackgroundColor: AegisColors.neutral100,
          disabledForegroundColor: AegisColors.textDisabled,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: style,
          padding: padding ?? EdgeInsets.symmetric(horizontal: paddingValue),
          elevation: elevation,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: isLoading
            ? SkLoadingAnimation(color: foregroundColor ?? AegisColors.neutral0)
            : Text(
                label,
                textAlign: TextAlign.center,
              ),
      ),
    );
  }

  static SkButton secondary({
    required String label,
    bool isLoading = false,
    bool stretch = true,
    VoidCallback? onPressed,
    double? elevation = 0,
    SkButtonSize size = SkButtonSize.regular,
    Size? customSize,
    EdgeInsetsGeometry? padding,
  }) {
    return SkButton(
      label: label,
      onPressed: onPressed,
      foregroundColor: AegisColors.purple300,
      backgroundColor: AegisColors.purple100,
      elevation: elevation,
      isLoading: isLoading,
      size: size,
      customSize: customSize,
      stretch: stretch,
    );
  }
}
