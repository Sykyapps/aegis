import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../foundation.dart';
import '../card/card.dart';
import 'formatter/currency_formatter.dart';

class SkCustomCurrencyField extends FormField<String> {
  final TextEditingController? controller;

  SkCustomCurrencyField({
    super.key,
    super.validator,
    this.controller,
    String? labelText,
    String? hintText,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    InputDecoration? decoration = const InputDecoration(),
    TextStyle? style,
  }) : super(
          builder: (FormFieldState<String> fieldState) {
            void onChangeHandler(String value) {
              var parsed = CurrencyInputFormatter.parse(value);
              fieldState.didChange(parsed);
              if (onChanged != null) onChanged(parsed);
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration()).applyDefaults(
              InputDecorationTheme(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
                fillColor: AegisColors.neutral100,
                hintStyle: AegisFont.headlineSmall.copyWith(
                  color: AegisColors.neutral300,
                ),
              ),
            );

            return SkCard(
              border: Border.all(
                color: fieldState.hasError
                    ? AegisColors.red300
                    : AegisColors.neutral200,
                width: 1.r,
                strokeAlign: StrokeAlign.outside,
              ),
              backgroundColor: AegisColors.neutral100,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8).r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (labelText != null) ...[
                      Text(
                        labelText,
                        style: AegisFont.bodySmall.copyWith(
                          color: fieldState.hasError
                              ? AegisColors.red300
                              : AegisColors.neutral300,
                        ),
                      ),
                      SizedBox(height: 4.r),
                    ],
                    TextField(
                      focusNode: focusNode,
                      controller: controller ?? TextEditingController(),
                      onChanged: onChangeHandler,
                      style: style ??
                          AegisFont.headlineSmall.copyWith(
                            color: AegisColors.neutral500,
                          ),
                      cursorWidth: 1.w,
                      cursorColor: AegisColors.blue300,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: effectiveDecoration.copyWith(
                        hintText: hintText,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        TextInputFormatter.withFunction(
                          (oldValue, newValue) {
                            if (newValue.selection.baseOffset == 0) {
                              return newValue;
                            }

                            double value = double.parse(newValue.text);
                            final fmt = NumberFormat.simpleCurrency(
                              locale: 'id_ID',
                              decimalDigits: 0,
                            );

                            final formattedValue = fmt.format(value);
                            return newValue.copyWith(
                              text: formattedValue,
                              selection: TextSelection.collapsed(
                                offset: formattedValue.length,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
}
