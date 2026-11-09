import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _openSheet(
  WidgetTester tester,
  Future<void> Function(BuildContext context) onOpen,
) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => Center(
              child: TextButton(
                onPressed: () => onOpen(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

SkSearchableOptionsBottomSheet<String> _sheet({
  List<String> options = const ['BCA', 'BRI', 'Mandiri'],
  void Function(String)? onSelected,
  bool showHandle = false,
}) {
  return SkSearchableOptionsBottomSheet<String>(
    title: 'Pilih Bank',
    searchHint: 'Cari bank',
    emptyTitle: 'Tidak ditemukan',
    emptyDescription: 'Coba kata kunci lain',
    options: options,
    getLabel: (option) => option,
    onSelected: onSelected,
    showHandle: showHandle,
  );
}

void main() {
  testWidgets('renders the title, search field, and every option',
      (tester) async {
    await _openSheet(tester, (context) => _sheet().show(context));

    expect(find.text('Pilih Bank'), findsWidgets);
    expect(find.byType(SkSearchField), findsOneWidget);
    expect(find.text('BCA'), findsOneWidget);
    expect(find.text('BRI'), findsOneWidget);
    expect(find.text('Mandiri'), findsOneWidget);
  });

  testWidgets('closes via SkCloseButton', (tester) async {
    await _openSheet(tester, (context) => _sheet().show(context));

    expect(find.byType(SkCloseButton), findsOneWidget);

    await tester.tap(find.byType(SkCloseButton));
    await tester.pumpAndSettle();

    expect(find.text('BCA'), findsNothing);
  });

  testWidgets('filters options from the search field', (tester) async {
    await _openSheet(tester, (context) => _sheet().show(context));

    await tester.enterText(find.byType(SkSearchField), 'mand');
    await tester.pumpAndSettle();

    expect(find.text('Mandiri'), findsOneWidget);
    expect(find.text('BCA'), findsNothing);
    expect(find.text('BRI'), findsNothing);
  });

  testWidgets('shows the empty state when nothing matches', (tester) async {
    await _openSheet(tester, (context) => _sheet().show(context));

    await tester.enterText(find.byType(SkSearchField), 'zzz');
    await tester.pumpAndSettle();

    expect(find.text('Tidak ditemukan'), findsOneWidget);
    expect(find.text('Coba kata kunci lain'), findsOneWidget);
  });

  testWidgets('returns the tapped option from pop', (tester) async {
    String? result;

    await _openSheet(tester, (context) async {
      result = await _sheet().show(context);
    });

    await tester.tap(find.text('BRI'));
    await tester.pumpAndSettle();

    expect(find.text('BRI'), findsNothing);
    expect(result, 'BRI');
  });

  testWidgets('onSelected keeps the sheet open', (tester) async {
    String? selected;

    await _openSheet(
      tester,
      (context) =>
          _sheet(onSelected: (option) => selected = option).show(context),
    );

    await tester.tap(find.text('Mandiri'));
    await tester.pumpAndSettle();

    expect(selected, 'Mandiri');
    expect(find.text('Mandiri'), findsOneWidget);
  });

  testWidgets('barrierDismissible: false keeps the sheet open', (tester) async {
    await _openSheet(
      tester,
      (context) => _sheet().show(context, barrierDismissible: false),
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.text('BCA'), findsOneWidget);
  });

  testWidgets('showHandle is off by default and rendered when enabled',
      (tester) async {
    await _openSheet(tester, (context) => _sheet().show(context));

    expect(find.byType(StadiumBorder), findsNothing);

    await tester.tap(find.byType(SkCloseButton));
    await tester.pumpAndSettle();

    await _openSheet(
      tester,
      (context) => _sheet(showHandle: true).show(context),
    );

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is ShapeDecoration &&
            (widget.decoration! as ShapeDecoration).shape is StadiumBorder,
      ),
      findsOneWidget,
    );
  });
}
