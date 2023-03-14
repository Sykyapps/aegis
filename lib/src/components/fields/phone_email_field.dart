import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_validator/form_validator.dart';

import '../../../foundation.dart';
import 'fields.dart';

class SkPhoneEmailField extends HookWidget {
  const SkPhoneEmailField({
    Key? key,
    required this.controller,
    this.errorMessage,
    this.requiredMessage,
  }) : super(key: key);

  final TextEditingController controller;
  final String? errorMessage;
  final String? requiredMessage;

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
      prefix: isPhoneMin && !hasNonDigit ? const _PhonePrefix() : null,
      validator: ValidationBuilder(requiredMessage: requiredMessage)
          .add(RegExpValidator.phoneEmailValidator)
          .build(),
    );
  }
}

class _PhonePrefix extends StatelessWidget {
  const _PhonePrefix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AegisColors.neutral100,
        borderRadius: BorderRadius.circular(2).r,
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4).r,
      margin: const EdgeInsets.only(right: 8).r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
            'https://storage.googleapis.com/sayakaya-static/country_flags/indonesia.svg',
            width: 25.r,
          ),
          SizedBox(width: 4.r),
          Text(
            '+62',
            style: AegisFont.bodyLarge.copyWith(
              color: AegisColors.neutral400,
              height: 24 / 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 4.r),
          Icon(Icons.keyboard_arrow_down, size: 16.r),
        ],
      ),
    );
  }
}
