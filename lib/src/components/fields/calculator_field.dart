import 'package:aegis/src/components/fields/formatter/thousands_separator_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../aegis.dart';
import 'formatter/decimal_text_input_formatter.dart';

class SkCalculatorField extends StatelessWidget {
  const SkCalculatorField({
    super.key,
    this.readOnly = false,
    this.suffixTitle,
    this.prefixTitle,
    this.controller,
    this.hintText,
    this.errorText,
    this.tooltipTitle,
    this.tooltipContent,
    this.validator,
    this.isDecimal = false,
    required this.label,
  });

  final bool readOnly;
  final String label;
  final String? suffixTitle;
  final String? prefixTitle;
  final TextEditingController? controller;
  final String? errorText;
  final String? hintText;
  final String? tooltipTitle;
  final String? tooltipContent;
  final String? Function(String?)? validator;
  final bool isDecimal;

  const SkCalculatorField.currency({
    super.key,
    this.readOnly = false,
    this.suffixTitle,
    this.prefixTitle = 'Rp',
    this.controller,
    this.hintText,
    this.errorText,
    this.tooltipTitle,
    this.tooltipContent,
    this.validator,
    this.isDecimal = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SkTextField(
      readOnly: readOnly,
      labelText: label,
      hintText: hintText,
      controller: controller,
      errorText: errorText,
      tooltipTitle: tooltipTitle ?? label,
      tooltipContent: tooltipContent,
      keyboardType: isDecimal
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.number,
      validator: validator,
      inputFormatters: prefixTitle != null
          ? [
              FilteringTextInputFormatter.digitsOnly,
              ThousandsSeparatorInputFormatter(),
            ]
          : isDecimal
              ? [DecimalTextInputFormatter(decimalRange: 2)]
              : [FilteringTextInputFormatter.digitsOnly],
      prefix: prefixTitle != null
          ? Container(
              color: AegisColors.neutral100,
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 4),
              child: Text(
                prefixTitle!,
                style: AegisFont.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AegisColors.neutral400,
                ),
              ),
            )
          : null,
      suffix: suffixTitle != null
          ? Container(
              color: AegisColors.neutral100,
              padding: const EdgeInsets.fromLTRB(12, 2, 12, 4),
              child: Text(
                suffixTitle!,
                style: AegisFont.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AegisColors.neutral400,
                ),
              ),
            )
          : null,
    );
  }
}
