import 'package:aegis/foundation.dart';
import 'package:flutter/widgets.dart';

class SkSectionTitle extends StatelessWidget {
  const SkSectionTitle(this.title, {super.key, this.titleStyle});

  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: titleStyle ??
          AegisFont.headlineSmall.copyWith(color: AegisColors.neutral500),
    );
  }
}
