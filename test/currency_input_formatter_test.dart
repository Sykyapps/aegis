import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

String type(CurrencyInputFormatter formatter, String shown, String typed) {
  var oldValue = TextEditingValue(
    text: shown,
    selection: TextSelection.collapsed(offset: shown.length),
  );
  var newText = shown + typed;
  var newValue = TextEditingValue(
    text: newText,
    selection: TextSelection.collapsed(offset: newText.length),
  );
  return formatter.formatEditUpdate(oldValue, newValue).text;
}

String typeAll(CurrencyInputFormatter formatter, List<String> keys) {
  var shown = '';
  for (var key in keys) {
    shown = type(formatter, shown, key);
  }
  return shown;
}

void main() {
  group('CurrencyInputFormatter — IDR', () {
    const formatter = CurrencyInputFormatter(currency: Currency.idr);

    test('formats whole numbers with thousands separators', () {
      expect(typeAll(formatter, ['1', '0', '0', '0', '0', '0']), 'Rp100,000');
    });

    test('ignores the decimal point', () {
      expect(typeAll(formatter, ['1', '0', '.', '5']), 'Rp105');
    });

    test('ignores a typed comma', () {
      expect(typeAll(formatter, ['1', '0', ',', '5']), 'Rp105');
    });

    test('backspace to the symbol clears the field', () {
      var cleared = formatter.formatEditUpdate(
        const TextEditingValue(
          text: 'Rp5',
          selection: TextSelection.collapsed(offset: 3),
        ),
        const TextEditingValue(
          text: 'Rp',
          selection: TextSelection.collapsed(offset: 2),
        ),
      );
      expect(cleared.text, '');
    });

    test('allowsDecimal is false', () {
      expect(CurrencyInputFormatter.allowsDecimal(Currency.idr), isFalse);
    });
  });

  group('CurrencyInputFormatter — USD', () {
    const formatter = CurrencyInputFormatter(currency: Currency.usd);

    test('formats whole numbers with thousands separators', () {
      expect(typeAll(formatter, ['1', '0', '0', '0']), '\$1,000');
    });

    test('accepts cents', () {
      expect(typeAll(formatter, ['1', '0', '0', '.', '5']), '\$100.5');
      expect(
        typeAll(formatter, ['1', '0', '0', '0', '.', '5', '0']),
        '\$1,000.50',
      );
    });

    test('keeps a trailing decimal point and zero mid-entry', () {
      expect(typeAll(formatter, ['1', '0', '0', '.']), '\$100.');
      expect(typeAll(formatter, ['1', '0', '0', '.', '0']), '\$100.0');
    });

    test('rejects a third decimal digit', () {
      expect(type(formatter, '\$100.50', '1'), '\$100.50');
    });

    test('rejects a second decimal point', () {
      expect(type(formatter, '\$100.5', '.'), '\$100.5');
    });

    test('a leading decimal point becomes 0.', () {
      expect(typeAll(formatter, ['.', '5']), '\$0.5');
    });

    test('a typed comma is read as the decimal point', () {
      expect(typeAll(formatter, ['1', '0', '0', ',', '5']), '\$100.5');
      expect(typeAll(formatter, ['1', '0', '0', '0', ',', '5']), '\$1,000.5');
    });

    test('backspace over the decimal point keeps the whole number', () {
      var result = formatter.formatEditUpdate(
        const TextEditingValue(
          text: '\$100.',
          selection: TextSelection.collapsed(offset: 5),
        ),
        const TextEditingValue(
          text: '\$100',
          selection: TextSelection.collapsed(offset: 4),
        ),
      );
      expect(result.text, '\$100');
    });

    test('allowsDecimal is true', () {
      expect(CurrencyInputFormatter.allowsDecimal(Currency.usd), isTrue);
    });
  });

  group('CurrencyInputFormatter static helpers', () {
    test('parse keeps cents for USD only', () {
      expect(
        CurrencyInputFormatter.parse('\$1,000.50', currency: Currency.usd),
        '1000.5',
      );
      expect(CurrencyInputFormatter.parse('Rp1,000'), '1000.0');
      expect(CurrencyInputFormatter.parse('\$', currency: Currency.usd), '');
      expect(CurrencyInputFormatter.parse('.', currency: Currency.usd), '');
    });

    test('format keeps cents for USD only', () {
      expect(
        CurrencyInputFormatter.format('1000.5', Currency.usd),
        '\$1,000.50',
      );
      expect(
          CurrencyInputFormatter.format('100000', Currency.idr), 'Rp100,000');
    });
  });

  group('Currency fields', () {
    Future<void> pump(WidgetTester tester, Widget field) {
      return tester.pumpWidget(
        ScreenUtilInit(
          designSize: const Size(360, 780),
          builder: (_, __) => MaterialApp(
            home: Scaffold(body: Form(child: field)),
          ),
        ),
      );
    }

    TextInputType keyboardOf(WidgetTester tester) =>
        tester.widget<TextField>(find.byType(TextField)).keyboardType;

    for (var currency in Currency.values) {
      var isUsd = currency == Currency.usd;
      var expectedValue = isUsd ? '100.5' : '1005.0';

      testWidgets('SkCurrencyBoxField (${currency.name})', (tester) async {
        String? changed;
        await pump(
          tester,
          SkCurrencyBoxField(
            currency: currency,
            onChanged: (value) => changed = value,
          ),
        );

        expect(
          keyboardOf(tester),
          TextInputType.numberWithOptions(decimal: isUsd),
        );
        await tester.enterText(find.byType(TextField), '100.5');
        expect(changed, expectedValue);
      });

      testWidgets('SkCurrencyField (${currency.name})', (tester) async {
        String? changed;
        await pump(
          tester,
          SkCurrencyField(
            currency: currency,
            onChanged: (value) => changed = value,
          ),
        );

        expect(
          keyboardOf(tester),
          TextInputType.numberWithOptions(decimal: isUsd),
        );
        await tester.enterText(find.byType(TextField), '100.5');
        expect(changed, expectedValue);
      });
    }
  });
}
