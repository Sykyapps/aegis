import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../../../foundation.dart';
import '../../../icons.dart';
import 'text_field.dart';

class SkPasswordField extends HookWidget {
  const SkPasswordField({
    super.key,
    required this.controller,
    this.errorMessage,
  });

  final TextEditingController controller;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    var obscureText = useState<bool>(true);

    return SkTextField(
      labelText: 'Kata Sandi',
      hintText: 'Masukkan kata sandi',
      errorText: errorMessage,
      obscureText: obscureText.value,
      controller: controller,
      suffix: IconButton(
        onPressed: () => obscureText.value = !obscureText.value,
        icon: Icon(
          obscureText.value ? AegisIcons.eye : AegisIcons.eye_off,
        ),
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        iconSize: 20.r,
        color: AegisColors.neutral300,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
      ),
      validator: ValidationBuilder(
        requiredMessage: 'Kata sandi wajib diisi',
      ).build(),
    );
  }
}
