import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkCard extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;

  const SkCard({
    Key? key,
    this.header,
    this.body,
    this.backgroundColor = AegisColors.neutral0,
    this.margin,
    this.boxShadow,
    this.border,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // * Card Wrapper
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border ??
            Border.all(
              color: AegisColors.neutral200,
              width: 1.r,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
        borderRadius: borderRadius ?? BorderRadius.circular(4).r,
        boxShadow: boxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // * Card Header
          header ?? const SizedBox(),
          // * Card Body
          body ?? const SizedBox(),
        ],
      ),
    );
  }
}
