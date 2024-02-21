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
    this.enabled = true,
    required this.controller,
    this.labelText,
    this.hintText,
    this.errorText,
    this.validator,
    this.phoneCode,
    this.phoneCodes,
    this.onCountrySelected,
    this.scrollPadding = const EdgeInsets.all(20),
  }) : super(key: key);

  final bool enabled;
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final SkPhoneEmailValidator? validator;
  final String? phoneCode;
  final List<Map<String, dynamic>>? phoneCodes;
  final Function(String)? onCountrySelected;
  final EdgeInsets scrollPadding;

  @override
  Widget build(BuildContext context) {
    var update = useValueListenable(controller);

    useEffect(() {
      controller.value = update;
      return;
    }, [update]);

    return SkTextField(
      enabled: enabled,
      labelText: labelText ?? 'Nomor Ponsel atau Email',
      hintText: hintText ?? 'Masukkan nomor ponsel atau email.',
      errorText: errorText,
      controller: controller,
      scrollPadding: scrollPadding,
      prefix: SkPhoneValidator.showPhoneCode(controller.text)
          ? PhonePrefix(
              phoneCode: phoneCode,
              phoneCodes: phoneCodes,
              onSelected: onCountrySelected,
            )
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
