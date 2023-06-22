class SkRegExp {
  // Basic
  static final anyAlphabet = RegExp(r'[A-Za-z]');
  static final anyDigit = RegExp(r'\d');
  static final anyNonDigit = RegExp(r'\D');
  static final anyLowerCase = RegExp('^(.*?[a-z]){1,}');
  static final anyUpperCase = RegExp('^(.*?[A-Z]){1,}');
  static final anyEmoticon = RegExp(
    '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
  );

  // Email
  static final email = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+\.[a-zA-Z.]{2,}$",
  );

  // Phone
  static final phone = RegExp(r'^\d{8,15}$');
  static final phoneMin = RegExp(r'^\d{6}');
}
