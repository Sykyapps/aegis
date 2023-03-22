import 'email_validator.dart';
import 'phone_validator.dart';
import 'regexp.dart';

class SkPhoneEmailValidator {
  final SkEmailValidator emailValidator;
  final SkPhoneValidator phoneValidator;
  final String required;
  final String noFormatMatches;

  SkPhoneEmailValidator({
    required this.emailValidator,
    required this.phoneValidator,
    this.required = defaultRequired,
    this.noFormatMatches = defaultNoFormatMatches,
  });

  // Default
  static const defaultRequired = 'Phone number or email is required';
  static const defaultNoFormatMatches =
      'Input must consist of letters or numbers';

  String? validate(String? value) {
    String text = value ?? '';
    if (SkRegExp.anyAlphabet.hasMatch(text)) {
      return emailValidator.validate(value);
    } else if (!SkRegExp.anyDigit.hasMatch(text)) {
      return noFormatMatches;
    }

    return phoneValidator.validate(value);
  }
}
