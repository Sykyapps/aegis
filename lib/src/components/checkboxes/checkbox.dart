import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../foundation.dart';
import '../semantics/semantics.dart';

class SkCheckbox extends StatelessWidget {
  const SkCheckbox({
    Key? key,
    this.isActive = false,
    this.isCircle = true,
    this.isValidated = false,
    this.isDisabled = false,
  }) : super(key: key);

  final bool isActive;
  final bool isCircle;
  final bool isValidated;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    var backgroundColor = AegisColors.neutral0;
    var foregroundColor = AegisColors.neutral0;
    var borderColor = AegisColors.borderHighEmphasis;
    var borderRadius = 2.r;

    if (isActive) {
      backgroundColor = isDisabled ? AegisColors.blue200 : AegisColors.blue300;
      borderColor = AegisColors.transparent;
      foregroundColor = AegisColors.neutral100;
    } else if (isValidated) {
      borderColor = AegisColors.red300;
    }

    if (isCircle) borderRadius = 20.r;

    return AnimatedSwitcher(
      duration: Duration.zero,
      child: SkSemantics(
        label: 'Checkbox',
        child: Container(
          height: 20.r,
          width: 20.r,
          padding: const EdgeInsets.symmetric(horizontal: 5).r,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: SvgPicture.asset(
            'assets/svg/check.svg',
            color: foregroundColor,
            package: 'aegis',
          ),
        ),
      ),
    );
  }
}
