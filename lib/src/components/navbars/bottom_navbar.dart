import 'package:aegis/foundation.dart';
import 'package:aegis/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkBottomNavigationBar extends StatelessWidget {
  const SkBottomNavigationBar({
    super.key,
    required this.children,
    this.contentAxis = Axis.vertical,
    this.backgroundColor = AegisColors.neutral0,
    this.isFloating = false,
  });

  final List<Widget> children;
  final Axis contentAxis;
  final Color backgroundColor;
  final bool isFloating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.fromLTRB(20, 16, 20, context.bottomPadding).r,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: isFloating
            ? [
                BoxShadow(
                  blurRadius: 8,
                  color: AegisColors.neutral500.withValues(alpha: 0.06),
                )
              ]
            : null,
      ),
      child: contentAxis == Axis.vertical
          ? Column(mainAxisSize: MainAxisSize.min, children: children)
          : Row(children: children),
    );
  }
}
