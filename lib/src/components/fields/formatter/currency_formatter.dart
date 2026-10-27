import 'package:flutter/services.dart';

import '../../../utils/currency_util.dart';

const _maxValue = 1000000000000000;

class CurrencyInputFormatter extends TextInputFormatter {
  const CurrencyInputFormatter({required this.currency});

  final Currency currency;

  static bool allowsDecimal(Currency currency) => currency.fractionDigits > 0;

  static String parse(String? text, {Currency currency = Currency.idr}) {
    if (text.toString().isEmpty) {
      return '';
    }

    var clean = _numericOnly(text!, currency);
    if (!clean.contains(RegExp(r'[0-9]'))) return '';
    return CurrencyUtil.parse(clean, currency: currency).toString();
  }

  static String filterDigit(String text) {
    var cleanString = FilteringTextInputFormatter.digitsOnly
        .formatEditUpdate(TextEditingValue.empty, TextEditingValue(text: text))
        .text;
    return cleanString;
  }

  static String format(String? text, Currency currency) {
    if (text.toString().isEmpty) {
      return '';
    }

    var clean = _numericOnly(text!, currency);
    if (!clean.contains(RegExp(r'[0-9]'))) return '';
    double value = CurrencyUtil.parse(clean, currency: currency);
    return CurrencyUtil.format(value, currency: currency);
  }

  static String _numericOnly(String text, Currency currency) {
    var pattern = allowsDecimal(currency) ? r'[^0-9.]' : r'[^0-9]';
    return text.replaceAll(RegExp(pattern), '');
  }

  static String _normalizeTypedComma(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;
    var cursor = newValue.selection.baseOffset;
    var isSingleInsert = text.length == oldValue.text.length + 1;
    if (isSingleInsert &&
        cursor > 0 &&
        cursor <= text.length &&
        text[cursor - 1] == ',') {
      return text.replaceRange(cursor - 1, cursor, '.');
    }
    return text;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var text = allowsDecimal(currency)
        ? _normalizeTypedComma(oldValue, newValue)
        : newValue.text;
    var clean = _numericOnly(text, currency);
    if (clean.isEmpty) {
      return const TextEditingValue(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    var parts = clean.split('.');
    var hasFraction = parts.length == 2;
    if (parts.length > 2 ||
        (hasFraction && parts.last.length > currency.fractionDigits)) {
      return oldValue;
    }

    var value = int.parse(parts.first.isEmpty ? '0' : parts.first);
    if (value > _maxValue) return oldValue;

    var formattedValue = CurrencyUtil.simpleFormat(value, currency: currency);
    if (hasFraction) formattedValue = '$formattedValue.${parts.last}';

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(
        offset: formattedValue.length,
      ),
    );
  }
}

// TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue, TextEditingValue newValue) {
//   if (newValue.selection.baseOffset == 0) {
//     return newValue;
//   }

//   var cleanDigit = filterDigit(newValue.text);
//   if (cleanDigit.isEmpty) return TextEditingValue.empty;
//   double value = double.parse(cleanDigit);
//   String newText = format(value.toString());

//   int offset =
//       newValue.selection.baseOffset <= 4 ? 4 : newValue.selection.baseOffset;
//   return newValue.copyWith(
//       text: newText, selection: TextSelection.collapsed(offset: offset));
// }

// @yos-syky references
// TextInputFormatter.withFunction(
//   (oldValue, newValue) {
//     if (newValue.selection.baseOffset == 0) {
//       return newValue;
//     }

//     double value = double.parse(newValue.text);
//     final fmt = NumberFormat.simpleCurrency(
//       locale: 'en_US',
//       decimalDigits: 0,
//     );

//     final formattedValue = fmt.format(value);
//     return newValue.copyWith(
//       text: formattedValue,
//       selection: TextSelection.collapsed(
//         offset: formattedValue.length,
//       ),
//     );
//   },
// )
