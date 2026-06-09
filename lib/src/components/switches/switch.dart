import 'package:aegis/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkSwitch extends HookWidget {
  final bool enabled;
  final bool value;

  final Size trackSize;
  final double thumbSize;
  final double padding;

  const SkSwitch({
    super.key,
    this.enabled = true,
    this.value = false,
  })  : trackSize = const Size(36, 24),
        thumbSize = 20,
        padding = 2;

  const SkSwitch.large({
    this.enabled = true,
    this.value = false,
    super.key,
  })  : trackSize = const Size(46, 30),
        thumbSize = 25,
        padding = 2.5;

  static const _thumbColor = AegisColors.neutral0;
  static const _disabledColor = AegisColors.neutral100;
  static const _inactiveColor = AegisColors.neutral200;
  static const _activeColor = AegisColors.blue300;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: trackSize.height.r,
      width: trackSize.width.r,
      padding: EdgeInsets.symmetric(horizontal: padding).r,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: !enabled
            ? _disabledColor
            : value
                ? _activeColor
                : _inactiveColor,
      ),
      child: AnimatedAlign(
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: SizedBox.square(
          dimension: thumbSize.r,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: enabled ? _thumbColor : AegisColors.iconDisabled,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
