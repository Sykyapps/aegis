import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkBasicBottomSheet extends StatelessWidget {
  const SkBasicBottomSheet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      enableDrag: false,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (_) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: Shadow.convertRadiusToSigma(4),
        sigmaY: Shadow.convertRadiusToSigma(4),
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        decoration: BoxDecoration(
          color: AegisColors.neutral0,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)).r,
        ),
        child: child,
      ),
    );
  }
}
