import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../animations/animations.dart';

class SkIconButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function()? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final EdgeInsetsGeometry padding;
  final BorderSide border;
  final bool isLoading;
  final int width;

  const SkIconButton({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.backgroundColor = AegisColors.neutral0,
    this.foregroundColor = AegisColors.neutral500,
    this.padding = EdgeInsets.zero,
    this.border = const BorderSide(color: AegisColors.neutral200),
    this.width = 125,
    this.isLoading = false,
  });

  factory SkIconButton.primary({
    required IconData icon,
    required String title,
    Function()? onPressed,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
    BorderSide border = BorderSide.none,
    bool isLoading = false,
  }) =>
      SkIconButton(
        title: title,
        icon: icon,
        onPressed: onPressed,
        backgroundColor: AegisColors.purple300,
        foregroundColor: AegisColors.neutral0,
        padding: padding,
        isLoading: isLoading,
      );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      child: ElevatedButton.icon(
        icon: isLoading
            ? SkLoadingAnimation(color: foregroundColor)
            : Icon(icon, color: foregroundColor),
        label: isLoading
            ? const SizedBox()
            : Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AegisFont.bodyMedium.copyWith(color: foregroundColor),
              ),
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: border,
            borderRadius: BorderRadius.circular(4),
          ),
          shadowColor: const Color(0xFF000000).withOpacity(0.08),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
