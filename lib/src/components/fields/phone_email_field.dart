import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

import 'fields.dart';
import 'phone/phone_prefix.dart';
import 'phone/phone_suffix.dart';

class SkPhoneEmailField extends HookWidget {
  const SkPhoneEmailField({
    Key? key,
    required this.controller,
    this.errorMessage,
    this.requiredMessage,
    this.phoneCodes,
    this.onCountrySelected,
  }) : super(key: key);

  final TextEditingController controller;
  final String? errorMessage;
  final String? requiredMessage;
  final List<Map<String, dynamic>>? phoneCodes;
  final Function(String)? onCountrySelected;

  @override
  Widget build(BuildContext context) {
    var update = useValueListenable(controller);

    useEffect(() {
      controller.value = update;
      return;
    }, [update]);

    var isPhoneMin = RegExpValidator.phoneRegExpMin.hasMatch(controller.text);
    var hasNonDigit =
        RegExpValidator.anyNonDigitRegExp.hasMatch(controller.text);

    return SkTextField(
      labelText: 'Nomor Ponsel atau Email',
      hintText: 'Masukkan nomor ponsel atau email.',
      errorText: errorMessage,
      controller: controller,
      prefix: isPhoneMin && !hasNonDigit
          ? PhonePrefix(phoneCodes: phoneCodes, onSelected: onCountrySelected)
          : null,
      suffix: isPhoneMin && !hasNonDigit ? const PhoneSuffix() : null,
      validator: ValidationBuilder(requiredMessage: requiredMessage)
          .add(RegExpValidator.phoneEmailValidator)
          .build(),
    );
  }
}
