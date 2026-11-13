import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'bottom_sheet.dart';

/// @Deprecated — use [SkBottomSheet.showAsDialog] or
/// `SkBottomSheet(showHeader: false)` instead.
///
/// Kept for compatibility only: every presentation goes through
/// [SkBottomSheet], so consumers that have not migrated yet still get the
/// same constraints, scrolling and safe-area behavior.
@Deprecated(
  'Gunakan SkBottomSheet.showAsDialog(). '
  'Akan dihapus pada rilis major berikutnya.',
)
class SkBasicBottomSheet<T> extends StatelessWidget {
  const SkBasicBottomSheet({Key? key, required this.child}) : super(key: key);

  final Widget child;

  Future<T?> show(BuildContext context) =>
      SkBottomSheet.showAsDialog<T>(context, child: child);

  @override
  Widget build(BuildContext context) => SkBottomSheet<T>(
        showHeader: false,
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: child,
      );
}
