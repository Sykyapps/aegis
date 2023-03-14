class RegExpValidator {
  // Basic
  static final anyAlphabetRegExp = RegExp(r'[A-Za-z]');
  static final anyDigitRegExp = RegExp(r'\d');
  static final anyNonDigitRegExp = RegExp(r'\D');

  // Email
  static final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+\.[a-zA-Z]+$",
  );

  // Phone Number
  static final phoneRegExp = RegExp(r'^\d{8,15}$');
  static final phoneRegExpMin = RegExp(r'^\d{6}');

  static String? emailValidator(String? value) {
    String text = value ?? '';

    if (emailRegExp.hasMatch(text)) return null;
    return 'Format email harus seperti email@email.com';
  }

  static String? phoneValidator(String? value) {
    String text = value ?? '';

    if (anyNonDigitRegExp.hasMatch(text)) {
      return 'Nomor ponsel harus terdiri atas angka saja';
    } else if (!phoneRegExp.hasMatch(text)) {
      return 'Nomor ponsel harus terdiri atas 8-15 angka';
    }
    return null;
  }

  static String? phoneEmailValidator(String? value) {
    String text = value ?? '';
    if (anyAlphabetRegExp.hasMatch(text)) {
      return emailValidator(value);
    } else if (!anyDigitRegExp.hasMatch(text)) {
      return 'Input harus terdiri dari huruf atau angka';
    }

    return phoneValidator(value);
  }
}
