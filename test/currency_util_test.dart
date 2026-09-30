import 'package:aegis/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyUtil default (no currency arg) — regression', () {
    test('format matches today\'s IDR output', () {
      expect(CurrencyUtil.format(100000), 'Rp100,000');
      expect(CurrencyUtil.format(100000, withSymbol: false), '100,000');
    });

    test('compactFormat matches today\'s IDR output', () {
      expect(CurrencyUtil.compactFormat(1500000), '1,5jt');
      expect(
        CurrencyUtil.compactFormat(1500000, withSymbol: true),
        'Rp1,5jt',
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

    test('IDR never shows decimals', () {
      expect(CurrencyUtil.format(100000.5), 'Rp100,001');
      expect(
        CurrencyUtil.simpleFormat(100000.5, currency: Currency.idr),
        'Rp100,001',
      );
      expect(CurrencyUtil.parse('Rp100.50'), 10050.0);
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

  group('CurrencyUtil with Currency.usd — cents', () {
    test('format shows 2 decimals only when there are cents', () {
      expect(CurrencyUtil.format(100, currency: Currency.usd), '\$100');
      expect(CurrencyUtil.format(100.5, currency: Currency.usd), '\$100.50');
      expect(
        CurrencyUtil.format(1234.05, currency: Currency.usd),
        '\$1,234.05',
      );
      expect(
        CurrencyUtil.format(
          100.5,
          withSymbol: false,
          currency: Currency.usd,
        ),
        '100.50',
      );
    });

    test('format rounds to cents', () {
      expect(CurrencyUtil.format(102.014, currency: Currency.usd), '\$102.01');
      expect(CurrencyUtil.format(99.999, currency: Currency.usd), '\$100');
    });

    test('simpleFormat follows the same cents rule', () {
      expect(CurrencyUtil.simpleFormat(100, currency: Currency.usd), '\$100');
      expect(
        CurrencyUtil.simpleFormat(100.5, currency: Currency.usd),
        '\$100.50',
      );
    });

    test('compactFormat uses K/M/B suffixes', () {
      expect(
        CurrencyUtil.compactFormat(
          16140000,
          withSymbol: true,
          currency: Currency.usd,
        ),
        '\$16.14M',
      );
      expect(
        CurrencyUtil.compactFormat(2500, currency: Currency.usd),
        '2.5K',
      );
    });

    test('parse keeps the decimal point', () {
      expect(CurrencyUtil.parse('\$100.50', currency: Currency.usd), 100.5);
      expect(
        CurrencyUtil.parse('\$1,234.05', currency: Currency.usd),
        1234.05,
      );
      expect(CurrencyUtil.parse('\$100.', currency: Currency.usd), 100.0);
    });
  });
}
