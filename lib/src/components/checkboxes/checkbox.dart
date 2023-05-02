import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../foundation.dart';

class SkCheckbox extends StatelessWidget {
  const SkCheckbox({Key? key, this.isActive = false}) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration.zero,
      child: isActive ? const _ActiveCheckbox() : const _Checkbox(),
    );
  }
}

class _ActiveCheckbox extends StatelessWidget {
  const _ActiveCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.r,
      width: 22.r,
      padding: const EdgeInsets.symmetric(horizontal: 5).r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AegisColors.blue300,
      ),
      child: SvgPicture.asset(
        'assets/svg/check.svg',
        color: AegisColors.neutral100,
        package: 'aegis',
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22.r,
      width: 22.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AegisColors.neutral0,
        border: Border.all(
          color: AegisColors.borderHighEmphasis,
        ),
      ),
    );
  }
}
