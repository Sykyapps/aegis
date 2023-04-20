import 'package:intl/intl.dart';

class CurrencyUtil {
  static var formatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp',
    decimalDigits: 0,
    customPattern: '\u00a4#,###',
  );

  static String format(dynamic value) {
    return formatter.format(value);
  }

  static String compactFormat(dynamic value) {
    var formatter = NumberFormat.compactCurrency(
      locale: 'id',
      symbol: '',
      decimalDigits: 2,
    );
    return formatter.format(value).replaceAll(RegExp(r'\s+'), '');
  }

  static String decimalFormat(dynamic value, {int? decimalDigits = 0}) {
    var decimal = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp',
      decimalDigits: decimalDigits,
      customPattern: '\u00a4#,###',
    );

    return decimal.format(value);
  }

  static double parse(String value) {
    var clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    return formatter.parse(clean).toDouble();
  }
}
