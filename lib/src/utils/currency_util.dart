import 'package:intl/intl.dart';

class CurrencyUtil {
  static String formatted(dynamic value) {
    var formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
      customPattern: '\u00a4#,###',
    );
    return formatter.format(value);
  }

  static String decimalFormatted(dynamic value) {
    var formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: value == 0 ? 0 : 2,
      customPattern: '\u00a4#,###',
    );
    return formatter.format(value);
  }

  static String compactFormatter(dynamic value) {
    var formatter = NumberFormat.compactCurrency(
      locale: 'id',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(value).replaceAll(RegExp(r'\s+'), '');
  }

  static String compactLongFormatter(dynamic value) {
    var formatter = NumberFormat.compactLong(locale: 'id');
    return formatter.format(value);
  }

  static int num(String value) {
    var formatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
      customPattern: '\u00a4#,###',
    );
    return formatter.parse(value).toInt();
  }
}
