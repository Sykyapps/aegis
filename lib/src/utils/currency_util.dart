import 'package:intl/intl.dart';

class CurrencyUtil {
  static var formatter = NumberFormat.currency(
    locale: 'id',
    symbol: 'Rp ',
    decimalDigits: 0,
    customPattern: '\u00a4#,###',
  );

  static String format(dynamic value) {
    return formatter.format(value);
  }

  static double parse(String value) {
    return formatter.parse(value).toDouble();
  }
}
