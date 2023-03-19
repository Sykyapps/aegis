import 'package:flutter/services.dart';

import '../../../../components.dart';

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var newText = newValue.text;
    if (newText.isNotEmpty) {
      var oldText = oldValue.text;
      if (newText.length > oldText.length) {
        if (RegExpValidator.showPhoneCode(newText) &&
            RegExpValidator.showPhoneCode(oldText)) {
          if (newText.startsWith('+62') && newText.length >= 9) {
            newText = newText.replaceFirst('+62', '');
          } else if (newText.startsWith('0')) {
            newText = newText.replaceFirst('0', '');
          }
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }
      }
    }

    return newValue;
  }
}
