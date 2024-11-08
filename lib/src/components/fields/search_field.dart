import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

class SkSearchField extends HookWidget {
  const SkSearchField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.style,
    this.hintStyle,
    this.prefixIcon,
    this.semanticsLabel = 'search_input',
  });

  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    var ctrl = controller ?? useTextEditingController();
    var textUpdate = useValueListenable(ctrl);

    useEffect(() {
      ctrl.value = textUpdate;
      return;
    }, [textUpdate]);

    return SkSemantics(
      identifier: semanticsLabel,
      child: TextFormField(
        controller: ctrl,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: style ??
            AegisFont.bodyLarge.copyWith(color: AegisColors.neutral500),
        cursorHeight: 24.h,
        cursorWidth: 1.w,
        cursorColor: AegisColors.blue300,
        textInputAction: TextInputAction.search,
        inputFormatters: [
          FilteringTextInputFormatter.deny(SkRegExp.anyEmoticon),
        ],
        decoration: InputDecoration(
          filled: true,
          fillColor: AegisColors.neutral100,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          hintText: hintText,
          hintStyle: hintStyle ??
              AegisFont.bodyLarge.copyWith(
                color: AegisColors.neutral300,
              ),
          prefixIcon: prefixIcon ?? const _SearchPrefix(),
          prefixIconConstraints: const BoxConstraints(),
          suffixIcon: ctrl.text.isNotEmpty
              ? _ClearButton(controller: ctrl, onChanged: onChanged)
              : null,
          suffixIconConstraints: const BoxConstraints(),
        ),
      ),
    );
  }
}

class _SearchPrefix extends StatelessWidget {
  const _SearchPrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12).copyWith(right: 9),
      child: const Icon(
        AegisIcons.search,
        color: AegisColors.neutral300,
      ),
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key, required this.controller, this.onChanged})
      : super(key: key);

  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        controller.clear();
        onChanged?.call('');
      },
      icon: const Icon(AegisIcons.close_circle_fill),
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.symmetric(horizontal: 8).r,
      iconSize: 20.r,
      color: AegisColors.neutral400,
      enableFeedback: false,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }
}
