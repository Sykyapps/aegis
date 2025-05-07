import 'package:aegis/foundation.dart';
import 'package:flutter/widgets.dart';

class SkSectionTitle extends StatelessWidget {
  const SkSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AegisFont.headlineSmall.copyWith(
        color: AegisColors.neutral500,
      ),
    );
  }
}
