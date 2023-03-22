import 'regexp.dart';

class SkEmailValidator {
  final String required;
  final String wrongFormat;

  SkEmailValidator({
    this.required = defaultRequired,
    this.wrongFormat = defaultWrongFormat,
  });

  // Default
  static const defaultRequired = 'Email is required';
  static const defaultWrongFormat =
      'The email format should be something like email@email.com';

  String? validate(String? value) {
    String text = value ?? '';

    if (SkRegExp.email.hasMatch(text)) return null;
    return wrongFormat;
  }
}
