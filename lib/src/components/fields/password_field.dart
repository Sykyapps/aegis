import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../../../foundation.dart';
import '../../../icons.dart';
import 'text_field.dart';
import 'validator.dart';

class SkPasswordField extends HookWidget {
  const SkPasswordField({
    super.key,
    required this.controller,
    this.showValidator = false,
    this.errorMessage,
  });

  final TextEditingController controller;
  final bool showValidator;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    var obscureText = useState<bool>(true);
    var hasLowerCase = useState<bool>(false);
    var hasUpperCase = useState<bool>(false);
    var hasNumber = useState<bool>(false);
    var hasMinChar = useState<bool>(false);

    return Column(
      children: [
        SkTextField(
          labelText: 'Kata Sandi',
          hintText: 'Masukkan kata sandi',
          errorText: errorMessage,
          obscureText: obscureText.value,
          controller: controller,
          onChanged: (password) {
            if (!showValidator) return;

            hasMinChar.value = password.length >= 8;
            hasLowerCase.value =
                RegExpValidator.anyLowerCaseRegExp.hasMatch(password);
            hasUpperCase.value =
                RegExpValidator.anyUpperCaseRegExp.hasMatch(password);
            hasNumber.value = RegExpValidator.anyDigitRegExp.hasMatch(password);
          },
          suffix: IconButton(
            onPressed: () => obscureText.value = !obscureText.value,
            icon: Icon(
              obscureText.value ? AegisIcons.eye_open : AegisIcons.eye_close,
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
          )
              .add((value) => showValidator
                  ? RegExpValidator.passwordValidator(value)
                  : null)
              .build(),
        ),
        if (showValidator)
          _PasswordValidator(
            hasLowerCase: hasLowerCase.value,
            hasUpperCase: hasUpperCase.value,
            hasNumber: hasNumber.value,
            hasMinChar: hasMinChar.value,
          ),
      ],
    );
  }
}

class _PasswordValidator extends StatelessWidget {
  const _PasswordValidator({
    Key? key,
    required this.hasLowerCase,
    required this.hasNumber,
    required this.hasUpperCase,
    required this.hasMinChar,
  }) : super(key: key);

  final bool hasLowerCase;
  final bool hasNumber;
  final bool hasUpperCase;
  final bool hasMinChar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12).r,
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasLowerCase,
                  icon: AegisIcons.check_circle_fill,
                  requirement: '1 Huruf kecil',
                ),
              ),
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasNumber,
                  icon: AegisIcons.check_circle_fill,
                  requirement: '1 Angka',
                ),
              ),
            ],
          ),
          SizedBox(height: 12.r),
          Row(
            children: [
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasUpperCase,
                  icon: AegisIcons.check_circle_fill,
                  requirement: '1 Huruf besar',
                ),
              ),
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasMinChar,
                  icon: AegisIcons.check_circle_fill,
                  requirement: 'Minimal 8 karakter',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PasswordValidatorItem extends StatelessWidget {
  const _PasswordValidatorItem({
    Key? key,
    required this.icon,
    required this.requirement,
    required this.valid,
  }) : super(key: key);

  final IconData icon;
  final String requirement;
  final bool valid;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: valid ? AegisColors.green400 : AegisColors.neutral200,
        ),
        SizedBox(width: 8.r),
        Text(
          requirement,
          style: AegisFont.bodySmall.copyWith(
            color: valid ? AegisColors.neutral500 : AegisColors.neutral300,
          ),
        ),
      ],
    );
  }
}
