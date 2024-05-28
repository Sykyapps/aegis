import 'package:aegis/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkOutlinedButton extends StatelessWidget {
  const SkOutlinedButton({
    super.key,
    required this.label,
    this.customSize,
    this.size = SkButtonSize.regular,
    this.stretch = false,
    this.textStyle,
    this.onPressed,
  }) : assert(size != SkButtonSize.custom || customSize != null,
            'If size is SkButtonSize.custom, customSize must be provided.');

  final SkButtonSize size;
  final String label;
  final Size? customSize;
  final TextStyle? textStyle;
  final bool stretch;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle ??
        switch (size) {
          SkButtonSize.small => AegisFont.bodySmall,
          SkButtonSize.medium => AegisFont.bodyMedium,
          SkButtonSize.regular => AegisFont.bodyLarge,
          _ => AegisFont.bodyMedium,
        }
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
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: AegisColors.borderHighEmphasis,
          ),
          foregroundColor: AegisColors.textLowEmphasis,
          backgroundColor: AegisColors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          textStyle: style,
          padding: EdgeInsets.symmetric(horizontal: paddingValue),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

enum SkButtonSize { small, medium, regular, custom }
