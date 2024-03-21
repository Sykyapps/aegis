import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';

import 'text_field.dart';
import 'validators/email_validator.dart';

class SkEmailField extends HookWidget {
  const SkEmailField({
    Key? key,
    required this.controller,
    this.enabled = true,
    this.labelText,
    this.hintText,
    this.errorText,
    this.validator,
    this.suffix,
    this.focusNode,
    this.validatorBuilder,
  }) : super(key: key);

  final TextEditingController controller;
  final bool enabled;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final Widget? suffix;
  final SkEmailValidator? validator;
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
      controller: controller,
      labelText: labelText ?? 'Alamat email',
      hintText: hintText ?? 'Masukkan alamat email',
      errorText: errorText,
      suffix: suffix,
      validator: validatorBuilder ??
          ValidationBuilder(requiredMessage: validator?.required)
              .add((value) => validator?.validate(value))
              .build(),
    );
  }
}
