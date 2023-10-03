import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../aegis.dart';

class SkCalculatorField extends StatelessWidget {
  const SkCalculatorField({
    super.key,
    this.suffixTitle = 'Tahun',
    this.controller,
    this.hintText,
    required this.label,
  });

  final String label;
  final String suffixTitle;
  final TextEditingController? controller;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return SkTextField(
      labelText: label,
      hintText: hintText,
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      suffix: Container(
        height: 28,
        width: 68,
        color: AegisColors.neutral100,
        child: Center(
          child: Text(
            suffixTitle,
            style: AegisFont.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AegisColors.neutral400,
            ),
          ),
        ),
      ),
    );
  }
}
