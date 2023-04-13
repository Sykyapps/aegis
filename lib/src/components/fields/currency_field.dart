import 'package:aegis/src/components/fields/formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../foundation.dart';

class SkCurrencyField extends FormField<String> {
  final TextEditingController? controller;
  SkCurrencyField({
    super.key,
    this.controller,
    FocusNode? focusNode,
    AutovalidateMode? autovalidateMode,
    InputDecoration? decoration = const InputDecoration(),
    String? hintText,
    String? helperText,
    String? labelText,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String?>? validator,
  }) : super(
          autovalidateMode: autovalidateMode,
          validator: validator,
          builder: (FormFieldState<String> fieldState) {
            void onChangedHandler(String value) {
              var parsed = CurrencyInputFormatter.parse(value);
              if (onChanged != null) onChanged(parsed);
              fieldState.didChange(parsed);
            }

            InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration()).applyDefaults(
              InputDecorationTheme(
                isDense: true,
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AegisColors.blue300,
                  ),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AegisColors.red300,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AegisColors.borderHighEmphasis,
                  ),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AegisColors.red300,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.r),
                hintStyle: AegisFont.bodyLarge.copyWith(
                  color: AegisColors.neutral300,
                ),
                helperStyle: AegisFont.bodyMedium.copyWith(
                  color: AegisColors.textLowEmphasis,
                ),
                labelStyle: AegisFont.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: fieldState.hasError
                      ? AegisColors.red300
                      : AegisColors.textHighEmphasis,
                ),
                errorStyle: AegisFont.bodyMedium.copyWith(
                  color: AegisColors.red300,
                ),
              ),
            );

            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (labelText != null)
                  Text(
                    labelText,
                    style: effectiveDecoration.labelStyle,
                  ),
                TextFormField(
                  controller: controller,
                  cursorColor: AegisColors.blue300,
                  cursorWidth: 1.r,
                  decoration: effectiveDecoration.copyWith(
                    hintText: hintText,
                    helperText: helperText,
                    errorText: fieldState.errorText,
                  ),
                  focusNode: focusNode,
                  onChanged: onChangedHandler,
                  style: AegisFont.bodyLarge.copyWith(
                    color: AegisColors.textHighEmphasis,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    CurrencyInputFormatter(),
                  ],
                ),
              ],
            );
          },
        );
}
