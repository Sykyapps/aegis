import 'package:aegis/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_validator/form_validator.dart';

void main() {
  String labelText = 'This is label text';
  String hintText = 'This is hint text';
  String helperText = 'This is helper text';
  Widget wut = SkUnitField(
    labelText: labelText,
    hintText: hintText,
    helperText: helperText,
  );

  Widget wrapper(Widget child) {
    return ScreenUtilInit(
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  group('Tests for `SkUnitField`', () {
    testWidgets('Should render to the widget tree', (tester) async {
      await tester.pumpWidget(wrapper(wut));

      final finder = find.byWidget(wut);
      expect(finder, findsOneWidget);
    });

    testWidgets('Should display label, hint, and helper text', (tester) async {
      await tester.pumpWidget(wrapper(wut));

      final labelFinder = find.text(labelText);
      final hintFinder = find.text(hintText);
      final helperFinder = find.text(helperText);

      expect(labelFinder, findsOneWidget);
      expect(hintFinder, findsOneWidget);
      expect(helperFinder, findsOneWidget);
    });

    group('Tests to ensure widget is able to receive focus', () {
      testWidgets('Should be able to receive focus', (tester) async {
        final focusNode = FocusNode();

        /// Will run after test
        addTearDown(focusNode.dispose);

        // ignore: no_leading_underscores_for_local_identifiers
        Widget _wut = SkUnitField(
          focusNode: focusNode,
        );

        await tester.pumpWidget(wrapper(_wut));

        final finder = find.byWidget(_wut);

        await tester.tap(finder);
        await tester.pumpAndSettle();

        expect(focusNode.hasFocus, isTrue);
      });

      testWidgets('Should show keyboard when request focus', (tester) async {
        final focusNode = FocusNode();
        addTearDown(focusNode.dispose);

        // ignore: no_leading_underscores_for_local_identifiers
        final _wut = SkUnitField(
          focusNode: focusNode,
        );

        await tester.pumpWidget(wrapper(_wut));

        expect(tester.testTextInput.isVisible, isFalse);

        focusNode.requestFocus();
        await tester.pumpAndSettle();

        expect(tester.testTextInput.isVisible, isTrue);
      });
    });

    group('Tests to ensure widget is able to receive input', () {
      testWidgets('Should able receive number only text', (tester) async {
        await tester.pumpWidget(wrapper(wut));

        String good = '10000';
        String bad = '10000a';

        final finder = find.byWidget(wut);

        await tester.enterText(finder, good);
        expect(find.text(good), findsOneWidget);

        await tester.enterText(finder, bad);
        expect(find.text(bad), findsNothing);
      });

      testWidgets('Should avoid input start with punctuation like dot or comma',
          (widgetTester) async {
        await widgetTester.pumpWidget(wrapper(wut));

        String input = '.1000';
        final finder = find.byWidget(wut);

        await widgetTester.enterText(finder, input);
        expect(find.text(''), findsOneWidget);
        expect(find.text(input), findsNothing);
      });

      testWidgets('Should convert dot to comma', (tester) async {
        await tester.pumpWidget(wrapper(wut));

        String input = '1000.2';
        String formatted = '1000,2';
        final finder = find.byType(SkUnitField);

        await tester.enterText(finder, input);
        expect(find.text(formatted), findsOneWidget);
      });

      testWidgets('Should ignore next dot/comma input when text contains comma',
          (tester) async {
        await tester.pumpWidget(wrapper(wut));

        String input = '1000.200,3';
        String expected = '1000,200';
        final finder = find.byWidget(wut);

        await tester.enterText(finder, input);
        expect(find.text(expected), findsOneWidget);
      });
    });

    group('Tests to ensure widget validates user input', () {
      final key = GlobalKey<FormFieldState<String>>();
      final validator = ValidationBuilder().required().build();
      // ignore: no_leading_underscores_for_local_identifiers
      Widget _wut = SkUnitField(
        key: key,
        validator: validator,
      );

      testWidgets('Should display error text', (tester) async {
        await tester.pumpWidget(wrapper(_wut));

        key.currentState!.validate();

        expect(key.currentState!.hasError, isTrue);
        expect(key.currentState!.errorText, isA<String>());
      });

      testWidgets('Should not allow empty input', (tester) async {
        await tester.pumpWidget(wrapper(_wut));

        expect(key.currentState!.isValid, isFalse);

        final finder = find.byWidget(_wut);
        await tester.enterText(finder, 'text');
        await tester.enterText(finder, '');

        expect(key.currentState!.isValid, isFalse);
      });
    });
  });
}
