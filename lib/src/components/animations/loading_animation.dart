import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../foundation.dart';

class SkLoadingAnimation extends StatelessWidget {
  final double size;
  final Color color;

  const SkLoadingAnimation({
    super.key,
    this.size = 40,
    this.color = AegisColors.neutral100,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: size.sp,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(2),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500),
              color: color,
            ),
          ),
        );
      },
    );
  }
}
