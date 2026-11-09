import 'package:aegis/aegis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _openSheet(
  WidgetTester tester,
  Future<void> Function(BuildContext context) onOpen,
) async {
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

double _screenHeight(WidgetTester tester) =>
    tester.view.physicalSize.height / tester.view.devicePixelRatio;

void main() {
  testWidgets('renders the header, content, and closes via the close button',
      (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        title: 'Judul Sheet',
        child: Text('Isi Sheet'),
      ).show(context),
    );

    expect(find.text('Judul Sheet'), findsOneWidget);
    expect(find.text('Isi Sheet'), findsOneWidget);
    expect(find.byType(SkCloseButton), findsOneWidget);

    await tester.tap(find.byType(SkCloseButton));
    await tester.pumpAndSettle();

    expect(find.text('Isi Sheet'), findsNothing);
  });

  testWidgets('showHeader: false removes the app bar', (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        showHeader: false,
        child: Text('Isi Sheet'),
      ).show(context),
    );

    expect(find.byType(SkSliverAppBar), findsNothing);
    expect(find.byType(SkCloseButton), findsNothing);
    expect(find.text('Isi Sheet'), findsOneWidget);
  });

  testWidgets('dismisses when the barrier is tapped', (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        child: Text('Isi Sheet'),
      ).show(context),
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.text('Isi Sheet'), findsNothing);
  });

  testWidgets('barrierDismissible: false keeps the sheet open', (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        child: Text('Isi Sheet'),
      ).show(context, barrierDismissible: false),
    );

    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    expect(find.text('Isi Sheet'), findsOneWidget);
  });

  testWidgets('returns a typed result from pop', (tester) async {
    String? result;

    await _openSheet(tester, (context) async {
      result = await SkBottomSheet<String>(
        title: 'Pilih',
        child: Builder(
          builder: (sheetContext) => TextButton(
            onPressed: () => Navigator.of(sheetContext).pop('nilai'),
            child: const Text('Pilih Ini'),
          ),
        ),
      ).show(context);
    });

    await tester.tap(find.text('Pilih Ini'));
    await tester.pumpAndSettle();

    expect(find.text('Pilih Ini'), findsNothing);
    expect(result, 'nilai');
  });

  testWidgets('custom close callback replaces the default pop', (tester) async {
    var closed = false;

    await _openSheet(
      tester,
      (context) => SkBottomSheet(
        title: 'Judul',
        onClose: () => closed = true,
        child: const Text('Isi Sheet'),
      ).show(context),
    );

    await tester.tap(find.byType(SkCloseButton));
    await tester.pumpAndSettle();

    expect(closed, isTrue);
    expect(find.text('Isi Sheet'), findsOneWidget);
  });

  testWidgets('bottomBar stays outside the scrollable area', (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        title: 'Judul',
        bottomBar: Text('Simpan'),
        child: SizedBox(height: 2000, child: Text('Isi Sheet')),
      ).show(context),
    );

    expect(find.text('Simpan'), findsOneWidget);
    expect(
      tester.getRect(find.text('Simpan')).bottom,
      lessThanOrEqualTo(_screenHeight(tester)),
    );
  });

  testWidgets('bottomInset adds padding below the content', (tester) async {
    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        bottomInset: 40,
        child: Text('Isi Sheet'),
      ).show(context),
    );

    final contentBottom = tester.getRect(find.text('Isi Sheet')).bottom;

    expect(_screenHeight(tester) - contentBottom, greaterThanOrEqualTo(40));
  });

  testWidgets('keyboard inset pushes the bottom bar up', (tester) async {
    const keyboardInset = 300.0;
    tester.view.viewInsets = FakeViewPadding(
      bottom: keyboardInset * tester.view.devicePixelRatio,
    );
    addTearDown(tester.view.resetViewInsets);

    await _openSheet(
      tester,
      (context) => const SkBottomSheet(
        bottomBar: Text('Simpan'),
        child: Text('Isi Sheet'),
      ).show(context),
    );

    expect(find.text('Simpan'), findsOneWidget);
    expect(
      tester.getRect(find.text('Simpan')).bottom,
      lessThanOrEqualTo(_screenHeight(tester) - keyboardInset),
    );
  });
}
