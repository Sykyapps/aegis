import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

import '../fields.dart';
import '../formatter/phone_formatter.dart';
import 'phone_prefix.dart';
import 'phone_suffix.dart';

class SkPhoneField extends HookWidget {
  const SkPhoneField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.labelText,
    this.hintText,
    this.errorText,
    this.validator,
    this.suffix,
    this.phoneCode,
    this.phoneCodes,
    this.onCountrySelected,
    this.focusNode,
    this.validatorBuilder,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabled;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? suffix;
  final SkPhoneValidator? validator;
  final String? phoneCode;
  final List<Map<String, dynamic>>? phoneCodes;
  final Function(String)? onCountrySelected;
  final FocusNode? focusNode;
  final String? Function(String?)? validatorBuilder;

  @override
  Widget build(BuildContext context) {
    var update = useValueListenable(controller);

    useEffect(() {
      controller.value = update;
      return;
    }, [update]);

    return SkTextField(
      focusNode: focusNode,
      enabled: enabled,
      labelText: labelText ?? 'Nomor Ponsel',
      hintText: hintText ?? 'Masukkan nomor ponsel.',
      errorText: errorText,
      controller: controller,
      keyboardType: TextInputType.number,
      prefix: PhonePrefix(
        phoneCode: phoneCode,
        phoneCodes: phoneCodes,
        onSelected: onCountrySelected,
      ),
      suffix: suffix ?? const PhoneSuffix(),
      validator: validatorBuilder ??
          ValidationBuilder(requiredMessage: validator?.required)
              .add((value) => validator?.validate(value))
              .build(),
      inputFormatters: [PhoneFormatter()],
    );
  }
}
