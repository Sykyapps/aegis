import 'package:intl/intl.dart';

enum Currency { idr, usd }

class CurrencyUtil {
  static const String _locale = 'en_US';
  static const String _compactLocale = 'id_ID';

  static int _fractionDigitsFor(dynamic value, Currency currency) {
    if (currency != Currency.usd || value is! num) return 0;
    return (value * 100).round() % 100 == 0 ? 0 : 2;
  }

  static String _symbolFor(Currency currency) {
    switch (currency) {
      case Currency.usd:
        return '\$';
      case Currency.idr:
        return 'Rp';
    }
  }

  static String simpleFormat(
    dynamic value, {
    required Currency currency,
  }) {
    var formatter = NumberFormat.simpleCurrency(
      locale: _locale,
      name: _symbolFor(currency),
      decimalDigits: _fractionDigitsFor(value, currency),
    );
    return formatter.format(value);
  }

  static String format(
    dynamic value, {
    bool withSymbol = true,
    Currency currency = Currency.idr,
  }) {
    var formatter = NumberFormat.currency(
      locale: _locale,
      symbol: _symbolFor(currency),
      decimalDigits: _fractionDigitsFor(value, currency),
      customPattern: '¤#,###',
    );
    var formatted = formatter.format(value);
    if (!withSymbol) {
      formatted = formatted.replaceAll(_symbolFor(currency), '');
    }
    return formatted;
  }

  static String compactFormat(
    dynamic value, {
    bool withSymbol = false,
    Currency currency = Currency.idr,
  }) {
    var formatter = NumberFormat.compactCurrency(
      locale: _compactLocale,
      symbol: withSymbol ? _symbolFor(currency) : '',
      decimalDigits: 2,
    );
    if (currency == Currency.usd) {
      formatter
        ..significantDigitsInUse = false
        ..minimumFractionDigits = 0
        ..maximumFractionDigits = 2;
    }
    return formatter.format(value).replaceAll(RegExp(r'\s+'), '');
  }

  static String decimalFormat(
    dynamic value, {
    int? decimalDigits = 0,
    Currency currency = Currency.idr,
  }) {
    var decimal = NumberFormat.currency(
      locale: _locale,
      symbol: _symbolFor(currency),
      decimalDigits: decimalDigits,
      customPattern: '¤#,###',
    );

    return decimal.format(value);
  }

  static double parse(String value, {Currency currency = Currency.idr}) {
    if (currency == Currency.usd) {
      return double.parse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
    }

    var formatter = NumberFormat.currency(
      locale: _locale,
      symbol: _symbolFor(currency),
      decimalDigits: 0,
    );
    var clean = value.replaceAll(RegExp(r'[^0-9]'), '');
    return formatter.parse(clean).toDouble();
  }

  static String compactLongFormat(dynamic value) {
    var formatter = NumberFormat.compactLong(locale: _compactLocale);
    return formatter.format(value);
  }
}
