import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkCard extends StatelessWidget {
  final Widget? header;
  final Widget? body;
  final Color backgroundColor;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;

  const SkCard({
    Key? key,
    this.header,
    this.body,
    this.backgroundColor = AegisColors.neutral0,
    this.margin,
    this.boxShadow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // * Card Wrapper
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: AegisColors.neutral200,
          width: 1.r,
          strokeAlign: StrokeAlign.outside,
        ),
        borderRadius: BorderRadius.circular(4).r,
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
