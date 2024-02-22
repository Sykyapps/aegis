import 'package:flutter/services.dart';

import '../validators/phone_validator.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;
    if (newText.isEmpty) return newValue;

    if (!SkPhoneValidator.showPhoneCode(newText)) return newValue;

    if (newText.startsWith('+62')) {
      newText = newText.replaceFirst('+62', '');
    } else if (newText.startsWith('62')) {
      newText = newText.replaceFirst('62', '');
    } else if (newText.startsWith('0')) {
      newText = newText.replaceFirst('0', '');
    }

    if (!SkPhoneValidator.showPhoneCode(newText)) return newValue;

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
