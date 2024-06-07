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
    this.helperText,
    this.helperStyle,
    this.showSuffix = false,
    this.scrollPadding = const EdgeInsets.all(30.0),
    this.onChanged,
    this.onTapOutside,
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
  final String? helperText;
  final TextStyle? helperStyle;
  final bool showSuffix;
  final EdgeInsets scrollPadding;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    var update = useValueListenable(controller);

    useEffect(() {
      controller.value = update;
      return;
    }, [update]);

    return SkTextField(
      onTapOutside: onTapOutside,
      focusNode: focusNode,
      enabled: enabled,
      labelText: labelText ?? 'Nomor Ponsel',
      hintText: hintText ?? 'Masukkan nomor ponsel.',
      errorText: errorText,
      helperText: helperText,
      helperStyle: helperStyle,
      controller: controller,
      scrollPadding: scrollPadding,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      prefix: PhonePrefix(
        phoneCode: phoneCode,
        phoneCodes: phoneCodes,
        onSelected: onCountrySelected,
      ),
      suffix: showSuffix ? suffix ?? const PhoneSuffix() : null,
      validator: validatorBuilder ??
          ValidationBuilder(requiredMessage: validator?.required)
              .add((value) => validator?.validate(value))
              .build(),
      inputFormatters: [PhoneFormatter()],
    );
  }
}
