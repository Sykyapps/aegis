import 'regexp.dart';

class SkPasswordValidator {
  final String required;
  final String wrongFormat;
  final String lowercase;
  final String uppercase;
  final String number;
  final String minChar;

  SkPasswordValidator({
    this.required = defaultRequired,
    this.wrongFormat = defaultWrongFormat,
    this.lowercase = defaultOneLowerCase,
    this.uppercase = defaultOneUpperCase,
    this.number = defaultOneNumber,
    this.minChar = defaultMinChar,
  });

  // Default
  static const defaultRequired = 'Password is required';
  static const defaultWrongFormat = 'Password does not meet the requirements';
  static const defaultOneLowerCase = '1 lowercase';
  static const defaultOneUpperCase = '1 uppercase';
  static const defaultOneNumber = '1 number';
  static const defaultMinChar = 'Min. 8 chars';

  String? validate(String? value) {
    String text = value ?? '';

    if (text.length >= 8 &&
        SkRegExp.anyLowerCase.hasMatch(text) &&
        SkRegExp.anyUpperCase.hasMatch(text) &&
        SkRegExp.anyDigit.hasMatch(text)) {
      return null;
    }

    return wrongFormat;
  }
}
