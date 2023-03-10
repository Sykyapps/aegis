import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';
import '../../../icons.dart';

enum SkFieldState {
  enabled,
  disabled,
  focused,
  error,
}

class SkTextField extends HookWidget {
  const SkTextField({
    super.key,
    this.enabled = true,
    this.validator,
    this.errorText,
    required this.labelText,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.prefix,
    this.suffix,
    this.focusNode,
  });

  final bool enabled;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String labelText;
  final String? hintText;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;

  Color getStateColor(SkFieldState value) {
    switch (value) {
      case SkFieldState.error:
        return AegisColors.red300;
      case SkFieldState.disabled:
        return AegisColors.neutral300;
      default:
        return AegisColors.neutral500;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fn = focusNode ?? useFocusNode();
    var ctrl = controller ?? useTextEditingController();
    var textUpdate = useValueListenable(ctrl);
    var fieldState = useState<SkFieldState>(
      errorText == null
          ? enabled
              ? SkFieldState.enabled
              : SkFieldState.disabled
          : SkFieldState.error,
    );

    // TODO(dany): this function not trigger rebuild
    // var getStateColor = useCallback(() {
    //   switch (fieldState.value) {
    //     case SkFieldState.error:
    //       return AegisColors.red300;
    //     case SkFieldState.disabled:
    //       return AegisColors.neutral300;
    //     default:
    //       return AegisColors.neutral500;
    //   }
    // }, [])();

    var error = useState<String?>(errorText);

    void onFocusChanged() {
      if (!enabled) return;
      if (error.value != null) return;
      if (fn.hasFocus) {
        fieldState.value = SkFieldState.focused;
      } else {
        fieldState.value = SkFieldState.enabled;
      }
    }

    void onErrorChanged() {
      if (error.value != null) {
        fieldState.value = SkFieldState.error;
      } else {
        fieldState.value = SkFieldState.enabled;
      }
    }

    useEffect(() {
      fn.addListener(onFocusChanged);
      error.addListener(onErrorChanged);
      return () {
        fn.removeListener(onFocusChanged);
        error.removeListener(onErrorChanged);
      };
    }, []);

    useEffect(() {
      ctrl.value = textUpdate;
      return;
    }, [textUpdate]);

    useEffect(() {
      error.value = errorText;
      onErrorChanged();
      return;
    }, [errorText]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AegisFont.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
            color: getStateColor(fieldState.value),
          ),
        ),
        TextFormField(
          enabled: enabled,
          focusNode: fn,
          controller: ctrl,
          onChanged: onChanged,
          validator: (value) => error.value = validator?.call(value),
          style: AegisFont.bodyLarge.copyWith(
            color: enabled ? null : AegisColors.neutral300,
          ),
          obscureText: obscureText,
          cursorHeight: 24.h,
          cursorWidth: 1.w,
          cursorColor: AegisColors.blue300,
          decoration: InputDecoration(
            isDense: true,
            enabled: enabled,
            focusedBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AegisColors.blue300,
              ),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AegisColors.red300,
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AegisColors.neutral200,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AegisColors.neutral200,
              ),
            ),
            errorBorder: const UnderlineInputBorder(
              borderRadius: BorderRadius.zero,
              borderSide: BorderSide(
                color: AegisColors.red300,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            hintText: hintText,
            hintStyle: AegisFont.bodyLarge.copyWith(
              color: AegisColors.neutral300,
            ),
            errorText: error.value,
            errorStyle: AegisFont.bodyMedium.copyWith(
              color: AegisColors.red300,
            ),
            prefixIcon: prefix,
            prefixIconConstraints: const BoxConstraints(),
            suffixIcon: suffix ??
                (fn.hasFocus && ctrl.text.isNotEmpty
                    ? _ClearButton(controller: ctrl)
                    : null),
            suffixIconConstraints: const BoxConstraints(),
          ),
        ),
      ],
    );
  }
}

class _ClearButton extends StatelessWidget {
  const _ClearButton({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => controller.clear(),
      icon: const Icon(AegisIcons.circle_close),
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.only(left: 8).r,
      iconSize: 20.r,
      color: AegisColors.neutral300,
      enableFeedback: false,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
    );
  }
}
