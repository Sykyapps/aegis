import 'package:flutter/material.dart';

import '../../foundation/colors.dart';
import '../../icons/icons.dart';
import 'fields.dart';

class SkTapField extends StatelessWidget {
  const SkTapField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onTap,
    this.hintText,
    this.validator,
  });

  final TextEditingController controller;

  final String labelText;
  final String? hintText;
  final VoidCallback onTap;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: IgnorePointer(
        child: SkTextField(
          controller: controller,
          labelText: labelText,
          hintText: hintText,
          validator: validator,
          suffix: const Icon(
            AegisIcons.chevron_down,
            color: AegisColors.neutral400,
          ),
        ),
      ),
    );
  }
}
