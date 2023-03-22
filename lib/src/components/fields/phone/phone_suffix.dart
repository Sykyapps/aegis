import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../foundation.dart';
import '../../../../icons.dart';

class PhoneSuffix extends StatelessWidget {
  const PhoneSuffix({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      AegisIcons.contact,
      size: 20.r,
      color: AegisColors.iconLowEmphasis,
    );
  }
}
