import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../aegis.dart';

class SkChoiceChip extends StatelessWidget {
  const SkChoiceChip({
    Key? key,
    this.label,
    required this.selected,
    required this.onSelected,
    this.child,
  }) : super(key: key);

  final String? label;
  final bool selected;
  final VoidCallback onSelected;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: child ?? Text(label ?? ''),
      selected: selected,
      pressElevation: 0,
      onSelected: (_) => onSelected(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 12.r),
      labelPadding: EdgeInsets.zero,
      checkmarkColor: AegisColors.neutral0,
      backgroundColor: AegisColors.backgroundWhite,
      selectedColor: AegisColors.blue300,
      labelStyle: AegisFont.bodyMedium.copyWith(
        color: selected ? AegisColors.backgroundWhite : AegisColors.neutral500,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r),
          side: BorderSide(
            color: selected
                ? AegisColors.transparent
                : AegisColors.borderHighEmphasis,
          )),
    );
  }
}
