import 'package:aegis/src/components/fields/formatter/thousands_separator_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../aegis.dart';
import 'formatter/decimal_text_input_formatter.dart';

class SkCalculatorField extends StatelessWidget {
  const SkCalculatorField({
    super.key,
    this.suffixTitle,
    this.prefixTitle,
    this.controller,
    this.hintText,
    this.tooltipTitle,
    this.tooltipContent,
    this.validator,
    this.isDecimal = false,
    required this.label,
  });

  final String label;
  final String? suffixTitle;
  final String? prefixTitle;
  final TextEditingController? controller;
  final String? hintText;
  final String? tooltipTitle;
  final String? tooltipContent;
  final String? Function(String?)? validator;
  final bool isDecimal;

  const SkCalculatorField.currency({
    super.key,
    this.suffixTitle,
    this.prefixTitle = 'Rp',
    this.controller,
    this.hintText,
    this.tooltipTitle,
    this.tooltipContent,
    this.validator,
    this.isDecimal = false,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SkTextField(
      labelText: label,
      hintText: hintText,
      controller: controller,
      tooltipTitle: tooltipTitle,
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
              height: 28,
              width: 43,
              color: AegisColors.neutral100,
              margin: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  prefixTitle!,
                  style: AegisFont.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AegisColors.neutral400,
                  ),
                ),
              ),
            )
          : null,
      suffix: suffixTitle != null
          ? Container(
              height: 28,
              width: 68,
              color: AegisColors.neutral100,
              child: Center(
                child: Text(
                  suffixTitle!,
                  style: AegisFont.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AegisColors.neutral400,
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
