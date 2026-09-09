import 'package:aegis/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyUtil default (no currency arg) — regression', () {
    test('format matches today\'s IDR output', () {
      expect(CurrencyUtil.format(100000), 'Rp100,000');
      expect(CurrencyUtil.format(100000, withSymbol: false), '100,000');
    });

    test('compactFormat matches today\'s IDR output', () {
      expect(CurrencyUtil.compactFormat(1500000), '1.5M');
      expect(
        CurrencyUtil.compactFormat(1500000, withSymbol: true),
        'Rp1.5M',
      );
    });

    test('decimalFormat matches today\'s IDR output', () {
      expect(CurrencyUtil.decimalFormat(100000), 'Rp100,000');
      expect(
        CurrencyUtil.decimalFormat(100000.5, decimalDigits: 2),
        'Rp100,000.50',
      );
    });

    test('parse matches today\'s IDR behaviour', () {
      expect(CurrencyUtil.parse('Rp100,000'), 100000.0);
    });
  });

  group('CurrencyUtil with Currency.idr explicit — same as default', () {
    test('format', () {
      expect(
        CurrencyUtil.format(100000, currency: Currency.idr),
        CurrencyUtil.format(100000),
      );
    });

    test('compactFormat', () {
      expect(
        CurrencyUtil.compactFormat(1500000, currency: Currency.idr),
        CurrencyUtil.compactFormat(1500000),
      );
    });

    test('decimalFormat', () {
      expect(
        CurrencyUtil.decimalFormat(100000, currency: Currency.idr),
        CurrencyUtil.decimalFormat(100000),
      );
    });

    test('parse', () {
      expect(
        CurrencyUtil.parse('Rp100,000', currency: Currency.idr),
        CurrencyUtil.parse('Rp100,000'),
      );
    });
  });

  group('CurrencyUtil with Currency.usd', () {
    test('format uses \$ symbol with en_US separators', () {
      expect(
        CurrencyUtil.format(100000, currency: Currency.usd),
        '\$100,000',
      );
    });

    test('format withSymbol: false strips the \$ symbol', () {
      expect(
        CurrencyUtil.format(
          100000,
          withSymbol: false,
          currency: Currency.usd,
        ),
        '100,000',
      );
    });

    test('compactFormat uses \$ symbol when withCurrency is true', () {
      expect(
        CurrencyUtil.compactFormat(
          1500000,
          withSymbol: true,
          currency: Currency.usd,
        ),
        '\$1.5M',
      );
    });

    test('compactFormat omits symbol when withCurrency is false', () {
      expect(
        CurrencyUtil.compactFormat(1500000, currency: Currency.usd),
        '1.5M',
      );
    });

    test('decimalFormat uses \$ symbol with en_US separators', () {
      expect(
        CurrencyUtil.decimalFormat(100000, currency: Currency.usd),
        '\$100,000',
      );
      expect(
        CurrencyUtil.decimalFormat(
          100000.5,
          decimalDigits: 2,
          currency: Currency.usd,
        ),
        '\$100,000.50',
      );
    });

    test('parse strips \$ symbol and thousands separators', () {
      expect(
        CurrencyUtil.parse('\$100,000', currency: Currency.usd),
        100000.0,
      );
    });
  });
}
