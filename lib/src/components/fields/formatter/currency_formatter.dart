import 'package:flutter/services.dart';

import '../../../utils/currency_util.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  static String parse(String? text) {
    if (text.toString().isEmpty) {
      return '';
    }

    var cleanDigit = filterDigit(text!);
    if (cleanDigit.isEmpty) return '';
    return CurrencyUtil.num(cleanDigit).toString();
  }

  static String format(String? text) {
    if (text.toString().isEmpty) {
      return '';
    }

    var cleanDigit = filterDigit(text!);
    if (cleanDigit.isEmpty) return '';
    double value = double.parse(cleanDigit);
    return CurrencyUtil.formatted(value);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var cleanDigit = filterDigit(newValue.text);
    if (cleanDigit.isEmpty) return TextEditingValue.empty;
    double value = double.parse(cleanDigit);
    String newText = CurrencyUtil.formatted(value);

    int offset =
        newValue.selection.baseOffset <= 4 ? 4 : newValue.selection.baseOffset;
    return newValue.copyWith(
        text: newText, selection: TextSelection.collapsed(offset: offset));
  }

  static String filterDigit(String text) {
    var cleanString = FilteringTextInputFormatter.digitsOnly
        .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
        .text;
    return cleanString;
  }
}
