import 'package:flutter/material.dart';

import '../../foundation/colors.dart';
import '../../icons/icons.dart';
import '../semantics/semantics.dart';
import 'fields.dart';

class SkTapField extends StatelessWidget {
  const SkTapField({
    super.key,
    this.enabled = true,
    required this.controller,
    required this.labelText,
    required this.onTap,
    this.hintText,
    this.validator,
    this.focusNode,
    this.readOnly = false,
  });

  final bool enabled;
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final VoidCallback onTap;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: !enabled
          ? null
          : () {
              FocusManager.instance.primaryFocus?.unfocus();
              onTap();
            },
      child: SkSemantics(
        label: 'Dropdown - $labelText',
        child: IgnorePointer(
          child: SkTextField(
            readOnly: readOnly,
            focusNode: focusNode,
            enabled: enabled,
            controller: controller,
            labelText: labelText,
            hintText: hintText,
            validator: validator,
            suffix: Icon(
              AegisIcons.chevron_down,
              color: enabled ? AegisColors.neutral400 : AegisColors.neutral300,
              semanticLabel: 'Dropdown - $hintText',
            ),
          ),
        ),
      ),
    );
  }
}
