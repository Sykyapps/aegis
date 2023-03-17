import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

import '../fields.dart';
import 'phone_prefix.dart';
import 'phone_suffix.dart';

class SkPhoneField extends HookWidget {
  const SkPhoneField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.errorMessage,
    this.requiredMessage,
    this.suffix,
    this.phoneCodes,
    this.onCountrySelected,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabled;
  final String? errorMessage;
  final String? requiredMessage;
  final Widget? suffix;
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
      enabled: enabled,
      labelText: 'Nomor HP',
      hintText: 'Masukkan nomor hp.',
      errorText: errorMessage,
      controller: controller,
      keyboardType: TextInputType.number,
      prefix: PhonePrefix(
        phoneCodes: phoneCodes,
        onSelected: onCountrySelected,
      ),
      suffix: suffix ?? const PhoneSuffix(),
      validator: ValidationBuilder(requiredMessage: requiredMessage)
          .add(RegExpValidator.phoneValidator)
          .build(),
    );
  }
}
