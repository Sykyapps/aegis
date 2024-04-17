import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';

import '../../../foundation.dart';
import '../../../icons.dart';
import 'text_field.dart';
import 'validators/validators.dart';

class SkPasswordField extends HookWidget {
  const SkPasswordField({
    super.key,
    this.enabled = true,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.showValidator = false,
    this.validator,
    this.focusNode,
    this.validatorBuilder,
    this.scrollPadding = const EdgeInsets.all(20),
  });

  final bool enabled;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final bool showValidator;
  final SkPasswordValidator? validator;
  final FocusNode? focusNode;
  final String? Function(String?)? validatorBuilder;
  final EdgeInsets scrollPadding;

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
          focusNode: focusNode,
          enabled: enabled,
          labelText: labelText ?? 'Kata Sandi',
          hintText: hintText ?? 'Masukkan kata sandi',
          errorText: errorText,
          obscureText: obscureText.value,
          controller: controller,
          scrollPadding: scrollPadding,
          onChanged: (password) {
            if (!showValidator) return;

            hasMinChar.value = password.length >= 8;
            hasLowerCase.value = SkRegExp.anyLowerCase.hasMatch(password);
            hasUpperCase.value = SkRegExp.anyUpperCase.hasMatch(password);
            hasNumber.value = SkRegExp.anyDigit.hasMatch(password);
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
          inputFormatters: [
            FilteringTextInputFormatter.deny(' '),
            FilteringTextInputFormatter.deny(SkRegExp.anyEmoticon),
          ],
          validator: validatorBuilder ??
              ValidationBuilder(requiredMessage: validator?.required)
                  .add((value) =>
                      showValidator ? validator?.validate(value) : null)
                  .build(),
        ),
        if (showValidator)
          _PasswordValidator(
            hasLowerCase: hasLowerCase.value,
            hasUpperCase: hasUpperCase.value,
            hasNumber: hasNumber.value,
            hasMinChar: hasMinChar.value,
            validator: validator ?? SkPasswordValidator(),
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
    required this.validator,
  }) : super(key: key);

  final bool hasLowerCase;
  final bool hasNumber;
  final bool hasUpperCase;
  final bool hasMinChar;
  final SkPasswordValidator validator;

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
                  requirement: validator.lowercase,
                ),
              ),
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasNumber,
                  icon: AegisIcons.check_circle_fill,
                  requirement: validator.number,
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
                  requirement: validator.uppercase,
                ),
              ),
              Flexible(
                child: _PasswordValidatorItem(
                  valid: hasMinChar,
                  icon: AegisIcons.check_circle_fill,
                  requirement: validator.minChar,
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
