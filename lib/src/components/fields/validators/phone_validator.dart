import 'regexp.dart';

class SkPhoneValidator {
  final String required;
  final String wrongFormat;
  final String lengthLimit;

  SkPhoneValidator({
    this.required = defaultRequired,
    this.wrongFormat = defaultWrongFormat,
    this.lengthLimit = defaultLengthLimit,
  });

  // Default
  static const defaultRequired = 'Phone number is required';
  static const defaultWrongFormat =
      'The phone number must consist of numbers only';
  static const defaultLengthLimit =
      'The mobile number must consist of 8-15 digits';

  static bool showPhoneCode(String value) {
    if (value.startsWith('+62')) return true;
    if (!SkRegExp.phoneMin.hasMatch(value)) return false;
    if (SkRegExp.anyNonDigit.hasMatch(value)) return false;
    return true;
  }

  String? validate(String? value) {
    String text = value ?? '';

    if (SkRegExp.anyNonDigit.hasMatch(text)) {
      return wrongFormat;
    } else if (!SkRegExp.phone.hasMatch(text)) {
      return lengthLimit;
    }
    return null;
  }
}
