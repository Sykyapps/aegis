import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

import 'fields.dart';
import 'formatter/phone_formatter.dart';
import 'phone/phone_prefix.dart';
import 'phone/phone_suffix.dart';

class SkPhoneEmailField extends HookWidget {
  const SkPhoneEmailField({
    Key? key,
    required this.controller,
    this.errorMessage,
    this.validator,
    this.phoneCodes,
    this.onCountrySelected,
  }) : super(key: key);

  final TextEditingController controller;
  final String? errorMessage;
  final SkPhoneEmailValidator? validator;
  final List<Map<String, dynamic>>? phoneCodes;
  final Function(String)? onCountrySelected;

  @override
  Widget build(BuildContext context) {
    var update = useValueListenable(controller);

    useEffect(() {
      controller.value = update;
      return;
    }, [update]);

    return SkTextField(
      labelText: 'Nomor Ponsel atau Email',
      hintText: 'Masukkan nomor ponsel atau email.',
      errorText: errorMessage,
      controller: controller,
      prefix: SkPhoneValidator.showPhoneCode(controller.text)
          ? PhonePrefix(phoneCodes: phoneCodes, onSelected: onCountrySelected)
          : null,
      suffix: SkPhoneValidator.showPhoneCode(controller.text)
          ? const PhoneSuffix()
          : null,
      validator: ValidationBuilder(requiredMessage: validator?.required)
          .add((value) => validator?.validate(value))
          .build(),
      inputFormatters: [
        FilteringTextInputFormatter.deny(' '),
        FilteringTextInputFormatter.deny(SkRegExp.anyEmoticon),
        PhoneFormatter(),
      ],
    );
  }
}
