import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../aegis.dart';

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
    this.style,
    this.validator,
    this.errorText,
    required this.labelText,
    this.hintText,
    this.helperText,
    this.helperStyle,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.prefix,
    this.suffix,
    this.focusNode,
    this.keyboardType,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.tooltipTitle,
    this.tooltipContent,
    this.scrollPadding = const EdgeInsets.all(30.0),
    this.readOnly = false,
    this.semanticLabel,
  });

  final bool enabled;
  final TextStyle? style;
  final FocusNode? focusNode;
  final FormFieldValidator<String>? validator;
  final String? errorText;
  final String labelText;
  final String? hintText;
  final String? helperText;
  final TextStyle? helperStyle;
  final bool obscureText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final String? tooltipTitle;
  final String? tooltipContent;
  final EdgeInsets scrollPadding;
  final bool readOnly;
  final String? semanticLabel;

  SkFieldState get baseState =>
      enabled ? SkFieldState.enabled : SkFieldState.disabled;

  @override
  Widget build(BuildContext context) {
    var fn = focusNode ?? useFocusNode();
    var ctrl = controller ?? useTextEditingController();
    var textUpdate = useValueListenable(ctrl);
    var fieldState = useState<SkFieldState>(
      errorText == null ? baseState : SkFieldState.error,
    );

    Color getStateColor() {
      switch (fieldState.value) {
        case SkFieldState.error:
          return AegisColors.red300;
        case SkFieldState.disabled:
          return AegisColors.neutral300;
        default:
          return AegisColors.neutral500;
      }
    }

    var error = useState<String?>(errorText);

    void onFocusChanged() {
      if (!enabled) return;
      if (error.value != null) return;
      if (fn.hasFocus) {
        fieldState.value = SkFieldState.focused;
      } else {
        fieldState.value = baseState;
      }
    }

    void onErrorChanged() {
      if (error.value != null) {
        fieldState.value = SkFieldState.error;
      } else {
        fieldState.value = baseState;
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
      return;
    }, [errorText]);

    useEffect(() {
      fieldState.value = baseState;
      return;
    }, [enabled]);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              labelText,
              style: AegisFont.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: getStateColor(),
              ),
            ),
            tooltipTitle != null && tooltipContent != null
                ? GestureDetector(
                    onTap: () async {
                      SkBottomSheet(
                        title: tooltipTitle,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: Text(
                            tooltipContent!,
                            style: AegisFont.bodyMedium,
                          ),
                        ),
                      ).show(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Icon(
                        AegisIcons.information_fill,
                        color: AegisColors.neutral300,
                        size: 15,
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
        SkSemantics(
          label: semanticLabel ?? labelText,
          child: TextFormField(
            enabled: enabled,
            focusNode: fn,
            controller: ctrl,
            onChanged: onChanged,
            readOnly: readOnly,
            validator: (value) => error.value = validator?.call(value),
            style: (style ?? AegisFont.bodyLarge).copyWith(
              color: enabled ? null : AegisColors.neutral300,
            ),
            obscureText: obscureText,
            cursorHeight: 24.h,
            cursorWidth: 1.w,
            cursorColor: AegisColors.blue300,
            keyboardType: keyboardType,
            inputFormatters: [
              FilteringTextInputFormatter.deny(SkRegExp.anyEmoticon),
              ...?inputFormatters,
            ],
            textCapitalization: textCapitalization,
            scrollPadding: scrollPadding,
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
              hintStyle: (style ?? AegisFont.bodyLarge).copyWith(
                color: AegisColors.neutral300,
              ),
              errorText: error.value,
              errorStyle: AegisFont.bodyMedium.copyWith(
                color: AegisColors.red300,
              ),
              errorMaxLines: 2,
              helperText: helperText,
              helperStyle: helperStyle ??
                  AegisFont.bodyMedium.copyWith(
                    color: AegisColors.textPositive,
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
      icon: const Icon(AegisIcons.close_circle_fill),
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
